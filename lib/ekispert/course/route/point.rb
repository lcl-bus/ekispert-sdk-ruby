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

        # Pointを継承するように書き換える
        class Station < EkispertBase
          attr_accessor :name_list, :yomi_list, :type_list

          def initialize(element)
            @name_list = []
            @yomi_list = []
            @type_list = []
            super(element)
          end

          class Name < EkispertBase; end
          class Yomi < EkispertBase; end
          class Type < EkispertBase; end
        end

        class Prefecture < EkispertBase
          attr_accessor :name_list

          def initialize(element)
            @name_list = []
            super(element)
          end

          class Name < EkispertBase; end
        end

        class GeoPoint < EkispertBase; end
      end
    end
  end
end
