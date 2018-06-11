module Ekispert
  class Course < EkispertBase
    attr_accessor :route_list, :price_list, :pass_status_list, :serialize_data_list

    def initialize(element)
      @route_list = []
      @price_list = []
      @pass_status_list = []
      @serialize_data_list = []
      super(element)
    end

    def self.get(**params)
      to_course(Ekispert::Client.get('search/course/extreme', params))
    end

    private

    def self.to_course(elem_arr)
      elem_arr.xpath('//Course').map { |course_elem| self.new(course_elem) }
    end
  end
end
