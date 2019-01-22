module Ekispert
  class TrainStationTimetable < EkispertBase
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

      def hour
        @hour_list[0].text
      end

      def time_reliability
        @time_reliability_list[0].text
      end

      def pre_cautional_comment
        @pre_cautional_comment_list[0]&.text
      end

      class Hour < EkispertBase; end
      class TimeReliability < EkispertBase; end
      class PreCautionalComment < EkispertBase; end
    end
  end
end
