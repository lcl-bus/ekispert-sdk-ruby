module Ekispert
  class Course < EkispertBase
    class Route < EkispertBase
      class Point < EkispertBase
        class Station < Point
          attr_accessor :name_list, :yomi_list, :type_list

          def initialize(element)
            @name_list = []
            @yomi_list = []
            @type_list = []
            super(element)
          end

          def name
            @name_list[0].text
          end

          def yomi
            @yomi_list[0].text
          end

          def type
            @type_list[0].text
          end

          class Name < EkispertBase; end
          class Yomi < EkispertBase; end
          class Type < EkispertBase; end
        end
      end
    end
  end
end
