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

    class WelfareFacilities < EkispertBase
      attr_reader :name_list, :comment_list
      def initialize(element)
        @name_list = []
        @comment_list = []
        super(element)
      end
      class Name < EkispertBase; end
      class Comment < EkispertBase; end
    end

    class Type < EkispertBase; end

    private

    def self.to_information_class(elem_arr)
      elem_arr.xpath('//Information').map { |elem| self.new(elem) }
    end
  end
end
