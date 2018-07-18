module Ekispert
  class Information < EkispertBase
    class Exit < EkispertBase
      attr_reader :name_list, :comment_list

      def initialize(element)
        @name_list = []
        @comment_list = []
        super(element)
      end

      class Name < EkispertBase; end
      class Comment < EkispertBase; end
    end
  end
end
