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

    def self.get(**params)
      to_information_class(Ekispert::Client.get('/station/info', params))
    end

    class Line < EkispertBase
      attr_reader :name_list, :type_list, :color_list
      def initialize(element)
        @name_list = []
        @type_list = []
        @color_list = []
        super(element)
      end
      class Name < EkispertBase; end
      class Type < EkispertBase; end
      class Color < EkispertBase; end
    end

    class Corporation < EkispertBase
      attr_reader :name_list
      def initialize(element)
        @name_list = []
        super(element)
      end
      class Name < EkispertBase; end
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

    class Exit < EkispertBase
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
