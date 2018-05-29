module Ekispert
  class Course < EkispertBase
    class Route < EkispertBase
      class Line < EkispertBase
        attr_accessor :arrival_state_list, :departure_state_list
        attr_accessor :corporation_list, :color_list
        attr_accessor :destination_list, :name_list, :number_list
        attr_accessor :time_reliability_list, :type_list, :typical_name_list

        def initialize(element)
          @arrival_state_list = []
          @departure_state_list = []
          @corporation_list = []
          @color_list = []
          @destination_list = []
          @name_list = []
          @number_list = []
          @time_reliability_list = []
          @type_list = []
          @typical_name_list = []
          super(element)
        end

        class ArrivalState < EkispertBase
          attr_accessor :gate_list, :datetime_list, :type_list

          def initialize(element)
            @gate_list = []
            @datetime_list = []
            @type_list = []
            super(element)
          end

          class Gate < EkispertBase
            attr_accessor :geo_point, :name_list

            def initialize(element)
              @geo_point_list = []
              @name_list = []
              super(element)
            end

            class GeoPoint < EkispertBase; end
            class Name < EkispertBase; end
          end
          class Datetime < EkispertBase; end
          class Type < EkispertBase; end
        end
        class DepartureState < EkispertBase
          attr_accessor :gate_list, :datetime_list, :type_list

          def initialize(element)
            @gate_list = []
            @datetime_list = []
            @type_list = []
            super(element)
          end

          class Gate < EkispertBase
            attr_accessor :geo_point, :name_list

            def initialize(element)
              @geo_point_list = []
              @name_list = []
              super(element)
            end

            class GeoPoint < EkispertBase; end
            class Name < EkispertBase; end
          end
          class Datetime < EkispertBase; end
          class Type < EkispertBase; end
        end
        class Corporation < EkispertBase
          class Name < EkispertBase; end
        end
        class Color < EkispertBase; end
        class Destination < EkispertBase; end
        class Name < EkispertBase; end
        class Number < EkispertBase; end
        class TimeReliability < EkispertBase; end
        class Type < EkispertBase; end
        class TypicalName < EkispertBase; end
      end
    end
  end
end
