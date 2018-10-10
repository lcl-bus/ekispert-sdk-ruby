module Ekispert
  class Course < EkispertBase
    class Route < EkispertBase
      class Line < EkispertBase
        class Stop < EkispertBase
          class DepartureState < EkispertBase
            attr_accessor :datetime_list

            def initialize(element)
              @datetime_list = []
              super(element)
            end

            class Datetime < EkispertBase; end
          end
        end
      end
    end
  end
end
