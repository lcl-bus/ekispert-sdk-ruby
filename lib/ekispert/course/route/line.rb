module Ekispert
  class Course::Route::Line < EkispertBase
    attr_accessor :arrival_state_list, :departure_state_list
    attr_accessor :corporation_list, :color_list
    attr_accessor :destination_list, :name_list, :number_list
    attr_accessor :time_reliability_list, :type_list, :typical_name_list
    attr_accessor :line_symbol_list, :stop_list
    attr_accessor :fare, :charge, :teiki1, :teiki3, :teiki6, :teiki12

    def initialize(element)
      @arrival_state_list = []
      @departure_state_list = []
      @corporation_list = []
      @color_list = []
      @destination_list = []
      @line_symbol_list = []
      @name_list = []
      @number_list = []
      @time_reliability_list = []
      @type_list = []
      @typical_name_list = []
      @stop_list = []
      super(element)
      @stop_list.each do |stop|
        stop.arrival_state&.set_date(departure_state.datetime)
        stop.departure_state&.set_date(departure_state.datetime)
      end
    end

    def arrival_state
      @arrival_state_list[0]
    end

    def departure_state
      @departure_state_list[0]
    end

    def corporation
      @corporation_list[0]
    end

    def color
      @color_list[0].text
    end

    def destination
      @destination_list[0].text
    end

    def line_symbol
      @line_symbol_list[0]
    end

    def name
      @name_list[0].text
    end

    def number
      @number_list[0]&.text
    end

    def time_reliability
      @time_reliability_list[0].text
    end

    def type
      @type_list[0]&.text
    end

    def typical_name
      @typical_name_list[0]&.text
    end

    class Color < EkispertBase; end
    class Destination < EkispertBase; end
    class Name < EkispertBase; end
    class Number < EkispertBase; end
    class TimeReliability < EkispertBase; end
    class Type < EkispertBase; end
    class TypicalName < EkispertBase; end
  end
end
