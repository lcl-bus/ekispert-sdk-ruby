module Ekispert
  class Course < EkispertBase
    class Route < EkispertBase
      class Point < EkispertBase
        class Station < EkispertBase
          attr_accessor :name_list, :yomi_list, :type_list

          def initialize(element)
            @name_list = []
            @yomi_list = []
            @type_list = []
            super(element)
          end

          class Name < EkispertBase; end
          class Yomi < EkispertBase; end
          class Type < EkispertBase; end
        end
      end
    end
  end
end
