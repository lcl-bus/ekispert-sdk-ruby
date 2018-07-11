module Ekispert
  class Course < EkispertBase
    class Route < EkispertBase
      class Line < EkispertBase
        class DepartureState < EkispertBase
          attr_accessor :gate_list, :datetime_list, :type_list

          def initialize(element)
            @gate_list = []
            @datetime_list = []
            @type_list = []
            super(element)
          end

          class Datetime < EkispertBase; end
          class Type < EkispertBase; end
        end
      end
    end
  end
end
