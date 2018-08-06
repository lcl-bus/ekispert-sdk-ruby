module Ekispert
  class TrainStationTimetable < EkispertBase
    class Station < EkispertBase
      attr_reader :name_list

      def initialize(element)
        @name_list = []
        super(element)
      end

      def name
        @name_list[0].text
      end

      class Name < EkispertBase; end
    end
  end
end
