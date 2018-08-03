module Ekispert
  class TrainTimeTable < EkispertBase
    class LineKind < EkispertBase
      attr_reader :mark_list

      def initialize(element)
        @mark_list = []
        super(element)
      end

      class Mark < EkispertBase; end
    end
  end
end
