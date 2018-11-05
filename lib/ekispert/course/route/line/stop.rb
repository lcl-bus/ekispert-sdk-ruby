module Ekispert
  class Course::Route::Line::Stop < EkispertBase
    attr_accessor :arrival_state_list, :departure_state_list, :point_list

    def initialize(element)
      @arrival_state_list = []
      @departure_state_list = []
      @point_list = []
      super(element)
    end

    def arrival_state
      @arrival_state_list[0]
    end

    def departure_state
      @departure_state_list[0]
    end

    def point
      @point_list[0]
    end
  end
end
