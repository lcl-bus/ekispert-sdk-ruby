module Ekispert
  class Course < EkispertBase
    class Route < EkispertBase
      class Point < EkispertBase
        attr_accessor :station_list, :prefecture_list, :geo_point_list

        def initialize(element)
          @station_list = []
          @prefecture_list = []
          @geo_point_list = []
          super(element)
        end

        def station
          @station_list[0]
        end

        def prefecture
          @prefecture_list[0]
        end

        def geo_point
          @geo_point_list[0]
        end

        class GeoPoint < EkispertBase; end
      end
    end
  end
end
