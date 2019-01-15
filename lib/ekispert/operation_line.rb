module Ekispert
  class OperationLine
    extend Ekispert::Util
    attr_accessor :corporation_list, :line_list

    def initialize
      @corporation_list = []
      @line_list = []
    end

    def self.find(params={})
      to_operation_line(Ekispert::Client.get('operationLine', params))
    end

    def self.to_operation_line(elem_arr)
      return nil if elem_arr.children.empty?

      operation_line = self.new
      elem_arr.children.each do |element|
        elem_name = element.name.to_sym
        next unless self.constants.include?(elem_name)

        # Ex. Ekispert::OperationLine::Corporation.new
        sub_instance = self.const_get(elem_name).new(element)
        class_list_name = "#{snakecase(elem_name)}_list"
        # Ex. operation_line.corporation_list << sub_instance
        operation_line.send(class_list_name) << sub_instance
      end
      operation_line
    end

    private_class_method :to_operation_line
  end
end
