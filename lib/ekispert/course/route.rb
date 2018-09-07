module Ekispert
  class Course < EkispertBase
    class Route < EkispertBase
      attr_accessor :line_list, :point_list

      def initialize(element)
        @line_list = []
        @point_list = []
        super(element)
      end

      def departure_time
        @line_list[0].departure_state_list[0].datetime
      end

      def arrival_time
        @line_list[-1].arrival_state_list[0].datetime
      end
    end
  end
end
