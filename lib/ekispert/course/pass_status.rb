module Ekispert
  class Course < EkispertBase
    class PassStatus < EkispertBase
      attr_accessor :comment_list, :name_list, :type_list

      def initialize(element)
        @comment_list = []
        @name_list = []
        @type_list = []
        super(element)
      end

      def comment
        @comment_list[0]&.text
      end

      def name
        @name_list[0]&.text
      end

      def type
        @type_list[0]&.text
      end

      class Comment < EkispertBase; end
      class Name < EkispertBase; end
      class Type < EkispertBase; end
    end
  end
end
