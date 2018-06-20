module Ekispert
  class Information < EkispertBase
    attr_accessor :line_list, :corporation_list, :welfare_facilities_list, :exit_list, :type_list

    def initialize(element)
      @line_list = []
      @corporation_list = []
      @welfare_facilities_list = []
      @exit_list = []
      @type_list = []
      super(element)
      relate_line_and_corporation
    end

    def relate_line_and_corporation
      # Set Information::Line#corporation
      @line_list.each do |line|
        line.corporation = @corporation_list.find { |corp| corp.index == line.corporation_index }
      end
      # Set Information::Corporation#line_list
      @corporation_list.each do |corp|
        corp.line_list = @line_list.select { |line| corp.index == line.corporation_index }
      end
    end

    def type
      @type_list[0].text
    end

    def self.get(**params)
      to_information(Ekispert::Client.get('station/info', params))
    end

    def self.to_information(elem_arr)
      elem_arr.xpath('//Information').map { |elem| self.new(elem) }
    end

    private_class_method :to_information

    class Type < EkispertBase; end
  end
end
