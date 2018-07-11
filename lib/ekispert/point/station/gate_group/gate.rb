module Ekispert
  class Point < EkispertBase
    class Station < Point
      class GateGroup < EkispertBase
        class Gate < EkispertBase
          attr_accessor :name_list, :geo_point_list

          def initialize(element)
            @name_list = []
            @geo_point_list = []
            super(element)
          end

          class Name < EkispertBase; end
          class GeoPoint < EkispertBase; end
        end
      end
    end
  end
end
