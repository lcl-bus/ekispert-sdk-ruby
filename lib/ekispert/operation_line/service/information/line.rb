module Ekispert
  class OperationLine
    class Service
      class Information
        class Line < EkispertBase
          attr_accessor :name_list

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
