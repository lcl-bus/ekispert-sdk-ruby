module Ekispert
  class Course < EkispertBase
    class Route < EkispertBase
      class Line < EkispertBase
        class Stop < EkispertBase
          class Point < EkispertBase
            attr_accessor :station_list, :prefecture_list
    
            def initialize(element)
              @station_list = []
              @prefecture_list = []
              super(element)
            end
          end
        end
      end
    end
  end
end
