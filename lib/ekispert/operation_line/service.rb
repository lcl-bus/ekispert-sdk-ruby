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
        xmls = Ekispert::Client.get('operationLine/service/rescuenow/information', params)
        return nil if xmls.children.empty?

        to_service(xmls)
      end

      def self.to_service(elem_arr)
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
        service.relate_corp_and_line

        service
      end

      # This method relate OperationLine::Service::Corporation instance
      # and OperationLine::Service::Information::Line instance.
      # Ex.
      #  OperationLine::Service::Corporation#line_list
      #  OperationLine::Service::Information::Line#corporation
      def relate_corp_and_line
        @corporation_list.each do |corp|
          @information_list.each do |info|
            next unless info.line.corporation_index == corp.index

            corp.line_list << info.line
            info.line.corporation = corp
          end
        end
      end

      private_class_method :to_service
    end
  end
end
