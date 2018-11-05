module Ekispert
  class Course::Route::Line::Stop::Point::Prefecture < EkispertBase
    attr_accessor :name_list

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
