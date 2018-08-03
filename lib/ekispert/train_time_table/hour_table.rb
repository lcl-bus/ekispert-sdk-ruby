module Ekispert
  class TrainTimeTable < EkispertBase
    class HourTable < EkispertBase
      attr_reader :hour_list, :minute_table_list
      attr_reader :time_reliability_list, :pre_cautional_comment_list

      def initialize(element)
        @hour_list = []
        @minute_table_list = []
        @time_reliability_list = []
        @pre_cautional_comment_list = []
        super(element)
      end

      class Hour < EkispertBase; end
      class TimeReliability < EkispertBase; end
      class PreCautionalComment < EkispertBase; end
    end
  end
end
