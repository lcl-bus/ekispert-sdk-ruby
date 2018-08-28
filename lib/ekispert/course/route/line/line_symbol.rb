module Ekispert
  class Course < EkispertBase
    class Route < EkispertBase
      class Line < EkispertBase
        class LineSymbol < EkispertBase
          attr_reader :name_list

          def initialize(element)
            @name_list = []
            super(element)
          end

          class Name < EkispertBase; end
        end
      end
    end
  end
end
