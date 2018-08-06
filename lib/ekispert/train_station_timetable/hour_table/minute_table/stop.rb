module Ekispert
  class TrainStationTimetable < EkispertBase
    class HourTable < EkispertBase
      class MinuteTable < EkispertBase
        class Stop < EkispertBase
          attr_reader :number_list

          def initialize(element)
            @number_list = []
            super(element)
          end

          def number
            @number_list[0].text
          end

          class Number < EkispertBase; end
        end
      end
    end
  end
end
