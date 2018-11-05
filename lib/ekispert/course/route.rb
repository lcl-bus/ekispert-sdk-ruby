module Ekispert
  class Course::Route < EkispertBase
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

    def departure_time
      @line_list[0].departure_state_list[0].datetime
    end

    def arrival_time
      @line_list[-1].arrival_state_list[0].datetime
    end

    def total_required_time
      time_other.to_i + time_on_board.to_i + time_walk.to_i
    end
  end
end
