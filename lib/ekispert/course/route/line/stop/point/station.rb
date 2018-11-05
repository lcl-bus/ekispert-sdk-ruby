module Ekispert
  class Course::Route::Line::Stop::Point::Station < EkispertBase
    attr_accessor :name_list, :prefecture_list

    def initialize(element)
      @name_list = []
      super(element)
    end

    def name
      @name_list[0].text
    end

    def prefecture
      @prefecture_list[0].name
    end

    class Name < EkispertBase; end
  end
end
