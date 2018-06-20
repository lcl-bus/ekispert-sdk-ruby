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
    end

    def type
      @type_list[0].text
    end

    def self.get(**params)
      to_information_class(Ekispert::Client.get('station/info', params))
    end

    class Type < EkispertBase; end

    private

    def self.to_information_class(elem_arr)
      elem_arr.xpath('//Information').map { |elem| self.new(elem) }
    end
  end
end
