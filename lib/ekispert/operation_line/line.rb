module Ekispert
  class OperationLine
    class Line < EkispertBase
      attr_reader :name_list, :yomi_list, :color_list
      attr_accessor :corporation

      def initialize(element)
        @name_list = []
        @yomi_list = []
        @color_list = []
        super(element)
      end

      def name
        @name_list[0].text
      end

      def yomi
        @yomi_list[0].text
      end

      def color
        @color_list[0].text
      end

      class Name < EkispertBase; end
      class Yomi < EkispertBase; end
      class Color < EkispertBase; end
    end
  end
end
