module Ekispert
  class OperationLine
    class Service
      extend Ekispert::Util
      attr_accessor :corporation_list, :information_list

      def initialize
        @corporation_list = []
        @information_list = []
      end

      def self.find(params={})
        to_service(Ekispert::Client.get('operationLine/service/rescuenow/information', params))
      end

      def self.to_service(elem_arr)
        return nil if elem_arr.children.empty?

        service = self.new
        elem_arr.children.each do |element|
          elem_name = element.name.to_sym
          next unless self.constants.include?(elem_name)

          # Ex. Ekispert::OperationLine::Service::Corporation.new
          sub_instance = self.const_get(elem_name).new(element)
          class_list_name = "#{snakecase(elem_name)}_list"
          # Ex. service.corporation_list << sub_instance
          service.send(class_list_name) << sub_instance
        end
        service
      end

      private_class_method :to_service
    end
  end
end
