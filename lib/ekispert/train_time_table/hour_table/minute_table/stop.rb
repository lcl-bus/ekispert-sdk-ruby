module Ekispert
  class TrainTimeTable < EkispertBase
    class HourTable < EkispertBase
      class MinuteTable < EkispertBase
        class Stop < EkispertBase
          attr_reader :number_list

          def initialize(element)
            @number_list = []
            super(element)
          end
        end
      end
    end
  end
end
