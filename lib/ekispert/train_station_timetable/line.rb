module Ekispert
  class TrainStationTimetable < EkispertBase
    class Line < EkispertBase
      attr_reader :name_list, :direction_list, :source_list, :color_list

      def initialize(element)
        @name_list = []
        @direction_list = []
        @source_list = []
        @color_list = []
        super(element)
      end

      def name
        @name_list[0].text
      end

      def direction
        @direction_list[0].text
      end

      def source
        @source_list[0]&.text
      end

      def color
        @color_list[0]&.text
      end

      class Name < EkispertBase; end
      class Direction < EkispertBase; end
      class Source < EkispertBase; end
      class Color < EkispertBase; end
    end
  end
end
