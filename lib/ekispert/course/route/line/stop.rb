module Ekispert
  class Course < EkispertBase
    class Route < EkispertBase
      class Line < EkispertBase
        class Stop < EkispertBase
          attr_accessor :arrival_state_list, :departure_state_list, :point_list

          def initialize(element)
            @arrival_state_list = []
            @departure_state_list = []
            @point_list = []
            super(element)
          end
        end
      end
    end
  end
end
