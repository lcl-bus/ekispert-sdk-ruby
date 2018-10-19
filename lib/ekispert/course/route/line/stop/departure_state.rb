module Ekispert
  class Course < EkispertBase
    class Route < EkispertBase
      class Line < EkispertBase
        class Stop < EkispertBase
          class DepartureState < EkispertBase
            attr_accessor :datetime_list, :datetime

            def initialize(element)
              @datetime_list = []
              super(element)
            end

            # Because of emptiness of date information at DepartureState, set date additionaly
            # ex. <Datetime operation="today">12:57:00+09:00</Datetime>
            def set_date(date)
              time = @datetime_list[0].text.split(/[:\+]/).first(3).map(&:to_i)
              @datetime = DateTime.new(date.year, date.month, date.day, *time)
            end

            class Datetime < EkispertBase; end
          end
        end
      end
    end
  end
end
