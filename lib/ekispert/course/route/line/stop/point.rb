module Ekispert
  class Course::Route::Line::Stop::Point < EkispertBase
    attr_accessor :station_list, :prefecture_list

    def initialize(element)
      @station_list = []
      @prefecture_list = []
      super(element)
      station.prefecture_list = prefecture_list
    end

    def station
      @station_list[0]
    end

    def prefecture
      @prefecture_list[0]
    end
  end
end
