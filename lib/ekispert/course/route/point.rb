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

        class GeoPoint < EkispertBase; end
      end
    end
  end
end
