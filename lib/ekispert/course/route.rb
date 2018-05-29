module Ekispert
  class Course < EkispertBase
    class Route < EkispertBase
      attr_accessor :line_list, :point_list

      def initialize(element)
        @line_list = []
        @point_list = []
        super(element)
      end
    end
  end
end
