module Ekispert
  class Course < EkispertBase
    class Route < EkispertBase
      class Line < EkispertBase
        class DepartureState < EkispertBase
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
        end
      end
    end
  end
end
