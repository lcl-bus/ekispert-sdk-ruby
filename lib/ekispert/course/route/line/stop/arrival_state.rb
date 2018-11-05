module Ekispert
  class Course::Route::Line::Stop::ArrivalState < EkispertBase
    attr_accessor :datetime_list, :datetime

    def initialize(element)
      @datetime_list = []
      super(element)
    end

    # Because of emptiness of date information at ArrivalState, set date additionaly
    # ex. <Datetime operation="today">12:57:00+09:00</Datetime>
    def set_date(date)
      time = @datetime_list[0].text.split(/[:\+]/).first(3).map(&:to_i)
      @datetime = DateTime.new(date.year, date.month, date.day, *time) rescue DateTime.now
      @datetime += 1 if @datetime_list[0].operation == 'yesterday'
    end

    class Datetime < EkispertBase; end
  end
end
