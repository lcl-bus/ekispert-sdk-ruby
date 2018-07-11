module Ekispert
  class Course < EkispertBase
    class Route < EkispertBase
      class Line < EkispertBase
        attr_accessor :arrival_state_list, :departure_state_list
        attr_accessor :corporation_list, :color_list
        attr_accessor :destination_list, :name_list, :number_list
        attr_accessor :time_reliability_list, :type_list, :typical_name_list
        attr_accessor :fare, :charge, :teiki1, :teiki3, :teiki6

        def initialize(element)
          @arrival_state_list = []
          @departure_state_list = []
          @corporation_list = []
          @color_list = []
          @destination_list = []
          @name_list = []
          @number_list = []
          @time_reliability_list = []
          @type_list = []
          @typical_name_list = []
          super(element)
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
  end
end
