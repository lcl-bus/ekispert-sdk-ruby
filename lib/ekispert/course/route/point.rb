module Ekispert
  class Course::Route::Point < EkispertBase
    attr_accessor :station_list, :prefecture_list, :geo_point_list
    attr_accessor :name_list

    def initialize(element)
      @station_list = []
      @prefecture_list = []
      @geo_point_list = []
      @name_list = []
      super(element)
      set_station_instance_variables if station?
    end

    def station
      @station_list[0]
    end

    def prefecture
      @prefecture_list[0]
    end

    def geo_point
      @geo_point_list[0]
    end

    def name
      @name_list[0]&.text
    end

    def station?
      station.instance_of?(Ekispert::Course::Route::Point::Station)
    end

    class GeoPoint < EkispertBase; end
    class Name < EkispertBase; end

    private

    def set_station_instance_variables
      station.prefecture_list = prefecture_list
      station.geo_point_list = geo_point_list
    end
  end
end
