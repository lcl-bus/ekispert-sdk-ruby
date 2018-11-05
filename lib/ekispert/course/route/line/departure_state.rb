module Ekispert
  class Course::Route::Line::DepartureState < EkispertBase
    attr_accessor :gate_list, :datetime_list, :type_list

    def initialize(element)
      @gate_list = []
      @datetime_list = []
      @type_list = []
      super(element)
    end

    def datetime
      DateTime.parse(@datetime_list[0].text)
    end

    class Datetime < EkispertBase; end
    class Type < EkispertBase; end
  end
end
