module Ekispert
  class OperationLine
    class Service
      class Information < EkispertBase
        attr_accessor :comment_list, :datetime_list, :line_list, :title_list

        def initialize(element)
          @comment_list = []
          @datetime_list = []
          @line_list = []
          @title_list = []
          super(element)
        end

        class Comment < EkispertBase; end
        class Datetime < EkispertBase; end
        class Title < EkispertBase; end
      end
    end
  end
end
