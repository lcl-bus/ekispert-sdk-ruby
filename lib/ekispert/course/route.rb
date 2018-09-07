module Ekispert
  class Course < EkispertBase
    class Route < EkispertBase
      attr_accessor :line_list, :point_list

      def initialize(element)
        @line_list = []
        @point_list = []
        super(element)
      end

      def departure_point
        @point_list[0]
      end

      def arrival_point
        @point_list[-1]
      end
    end
  end
end
