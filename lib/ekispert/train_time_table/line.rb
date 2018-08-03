module Ekispert
  class TrainTimeTable < EkispertBase
    class Line < EkispertBase
      attr_reader :name_list, :direction_list, :source_list, :color_list

      def initialize(element)
        @name_list = []
        @direction_list = []
        @source_list = []
        @color_list = []
        super(element)
      end

      class Name < EkispertBase; end
      class Direction < EkispertBase; end
      class Source < EkispertBase; end
      class Color < EkispertBase; end
    end
  end
end
