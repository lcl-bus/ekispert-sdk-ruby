module Ekispert
  class Point < EkispertBase
    attr_accessor :station_list, :prefecture_list, :geo_point_list

    def initialize(element)
      @station_list = []
      @prefecture_list = []
      @geo_point_list = []
      super(element)
    end

    # request to '/station' or '/station/light'
    # and parse Point class
    def self.get_station(**params)
      path = station_request_path(params)
      to_point(Ekispert::Client.get(path, params))
    end

    private

    def self.station_request_path(**request_params)
      Station::PAID_REQUEST_PARAMS.any? { |param| request_params.key?(param) } ? '/station' : '/station/light'
    end

    def self.to_point(elem_arr)
      point_list = []
      elem_arr.xpath('//Point').each { |point_elem| point_list << self.new(point_elem) }
      point_list
    end
  end
end
