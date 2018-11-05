module Ekispert
  class Course::PassStatus < EkispertBase
    attr_accessor :comment_list, :name_list, :type_list
    attr_accessor :price_list

    def initialize(element=nil)
      @comment_list = []
      @name_list = []
      @type_list = []
      @price_list = [] # Use Course#relate_price_and_pass_status
      return if element.nil?

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
