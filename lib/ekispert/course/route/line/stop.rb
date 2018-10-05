module Ekispert
  class Course < EkispertBase
    class Route < EkispertBase
      class Line < EkispertBase
        class Stop < EkispertBase
          attr_reader :point_list, :departure_state_list, :arrival_state_list

          def initialize(element)
            @point_list = []
            @departure_state_list = []
            @arrival_state_list = []
            super(element)
          end

          def point
            @point_list[0]
          end

          def departure_state
            @departure_state_list[0]
          end

          def arrival_state
            @arrival_state_list[0]
          end
        end
      end
    end
  end
end
