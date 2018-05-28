module Ekispert
  class Course < EkispertBase

    def initialize(element)
      super(element)
    end

    def self.get(**params)
      to_course(Ekispert::Client.get('/search/course/extreme', params))
    end

    private

    def self.to_course(elem_arr)
      elem_arr.xpath('//Course').map { |course_elem| self.new(course_elem) }
    end
  end
end
