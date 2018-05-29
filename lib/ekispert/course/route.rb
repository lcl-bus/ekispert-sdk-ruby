module Ekispert
  class Course < EkispertBase
    class Route < EkispertBase
      attr_accessor :line_list

      def initialize(element)
        @line_list = []
        super(element)
      end
    end
  end
end
