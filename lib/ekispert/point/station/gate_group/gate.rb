module Ekispert
  class Point::Station::GateGroup::Gate < EkispertBase
    attr_accessor :name_list, :geo_point_list

    def initialize(element)
      @name_list = []
      @geo_point_list = []
      super(element)
    end

    def name
      @name_list[0].text
    end

    def geo_point
      @geo_point_list[0]
    end

    class Name < EkispertBase; end
    class GeoPoint < EkispertBase; end
  end
end
