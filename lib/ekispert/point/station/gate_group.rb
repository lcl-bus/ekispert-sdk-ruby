module Ekispert
  class Point < EkispertBase
    class Station < Point
      class GateGroup < EkispertBase
        attr_accessor :gate_list

        def initialize(element)
          @gate_list = []
          super(element)
        end
      end
    end
  end
end
