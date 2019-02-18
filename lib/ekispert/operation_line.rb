module Ekispert
  class OperationLine
    extend Ekispert::Util
    attr_accessor :corporation_list, :line_list

    def initialize
      @corporation_list = []
      @line_list = []
    end

    def self.find(params={})
      xmls = Ekispert::Client.get('operationLine', params)
      return nil if xmls.children.empty?

      to_operation_line(xmls)
    end

    def self.to_operation_line(elem_arr)
      operation_line = self.new
      elem_arr.children.each do |element|
        elem_name = element.name.to_sym
        next unless self.constants.include?(elem_name)

        # Ex. Ekispert::OperationLine::Corporation.new
        sub_instance = self.const_get(elem_name).new(element)
        # Ex. operation_line.corporation_list << sub_instance
        operation_line.send("#{snakecase(elem_name)}_list") << sub_instance
      end
      operation_line.relate_corp_and_line
      operation_line
    end

    # This method relate OperationLine::Corporation instance and OperationLine::Line instance.
    # Ex.
    #  OperationLine::Corporation#line_list
    #  OperationLine::Line#corporation
    def relate_corp_and_line
      @corporation_list.each do |corp|
        @line_list.each do |line|
          next unless line.corporation_index == corp.index

          corp.line_list << line
          line.corporation = corp
        end
      end
    end

    private_class_method :to_operation_line
  end
end
