module Ekispert
  class Information::Line < EkispertBase
    attr_reader :name_list, :type_list, :color_list
    attr_accessor :corporation

    def initialize(element)
      @name_list = []
      @type_list = []
      @color_list = []
      super(element)
    end

    def name
      @name_list[0].text
    end

    def type
      @type_list[0].text
    end

    def type_detail
      @type_list[0].respond_to?(:detail) ? @type_list[0].detail : nil
    end

    def color
      @color_list[0].text
    end

    class Name < EkispertBase; end
    class Type < EkispertBase; end
    class Color < EkispertBase; end
  end
end
