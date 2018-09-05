module Ekispert
  class Course < EkispertBase
    class Route < EkispertBase
      class Line < EkispertBase
        class ArrivalState < EkispertBase
          attr_accessor :gate_list, :datetime_list, :type_list

          def initialize(element)
            @gate_list = []
            @datetime_list = []
            @type_list = []
            super(element)
          end

          def datetime
            DateTime.parse(@datetime_list[0].text)
          end

          class Datetime < EkispertBase; end
          class Type < EkispertBase; end
        end
      end
    end
  end
end
