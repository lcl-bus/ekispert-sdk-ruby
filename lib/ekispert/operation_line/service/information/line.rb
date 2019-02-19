module Ekispert
  class OperationLine
    class Service
      class Information
        class Line < EkispertBase
          attr_accessor :name_list, :corporation

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
  end
end
