module Ekispert
  class Information < EkispertBase
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
  end
end
