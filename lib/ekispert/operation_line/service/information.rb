module Ekispert
  class OperationLine
    class Service
      class Information < EkispertBase
        attr_accessor :comment_list, :datetime_list, :line_list, :title_list, :corporation

        def initialize(element)
          @comment_list = []
          @datetime_list = []
          @line_list = []
          @title_list = []
          super(element)
        end

        def comment
          @comment_list.find { |comment| comment.status == 'long' }.text
        end

        def short_comment
          @comment_list.find { |comment| comment.status == 'short' }.text
        end

        def datetime
          DateTime.parse(@datetime_list[0].text)
        end

        def line
          @line_list[0]
        end

        def title
          @title_list[0].text
        end

        class Comment < EkispertBase; end
        class Datetime < EkispertBase; end
        class Title < EkispertBase; end
      end
    end
  end
end
