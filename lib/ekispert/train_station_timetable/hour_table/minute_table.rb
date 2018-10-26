module Ekispert
  class TrainStationTimetable < EkispertBase
    class HourTable < EkispertBase
      class MinuteTable < EkispertBase
        attr_reader :minute_list, :stop_list

        def initialize(element)
          @minute_list = []
          @stop_list = []
          super(element)
        end

        class Minute < EkispertBase; end
      end
    end
  end
end
