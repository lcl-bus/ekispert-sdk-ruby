module Ekispert
  class TrainTimeTable < EkispertBase
    attr_reader :station_list, :datetime_list, :hour_table_list
    attr_reader :line_list, :line_destination_list
    attr_reader :line_kind_list, :line_name_list
    attr_reader :information_list

    def initialize(element)
      @station_list = []
      @hour_table_list = []
      @datetime_list = []
      @line_list = []
      @line_destination_list = []
      @line_kind_list = []
      @line_name_list = []
      @information_list = []
      super(element)
    end

    def self.get(**params)
      to_train_time_table(Ekispert::Client.get('operationLine/timetable', params))
    end

    def self.to_train_time_table(elem_arr)
      elem_arr.xpath('//TimeTable').map { |elem| self.new(elem) }
    end

    private_class_method :to_train_time_table

    class Datetime < EkispertBase; end
  end
end
