module Ekispert
  class TrainTimeTable < EkispertBase
    class Station < EkispertBase
      attr_reader :name_list

      def initialize(element)
        @name_list = []
        super(element)
      end
    end
  end
end
