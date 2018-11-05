module Ekispert
  class Course::Route::Line::DepartureState::Gate < EkispertBase
    attr_accessor :geo_point, :name_list

    def initialize(element)
      @geo_point_list = []
      @name_list = []
      super(element)
    end

    class GeoPoint < EkispertBase; end
    class Name < EkispertBase; end
  end
end
