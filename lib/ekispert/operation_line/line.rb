module Ekispert
  class OperationLine
    class Line < EkispertBase
      attr_reader :name_list, :yomi_list, :color_list

      def initialize(element)
        @name_list = []
        @yomi_list = []
        @color_list = []
        super(element)
      end

      class Name < EkispertBase; end
      class Yomi < EkispertBase; end
      class Color < EkispertBase; end
    end
  end
end
