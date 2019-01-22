module Ekispert
  class TrainStationTimetable < EkispertBase
    attr_reader :station_list, :datetime_list, :hour_table_list
    attr_reader :line_list, :line_destination_list
    attr_reader :line_kind_list, :line_name_list, :information_list

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
      relate_stop_to_line
    end

    def station
      @station_list[0]
    end

    def datetime
      @datetime_list[0]
    end

    def line
      @line_list[0]
    end

    def self.get(params={})
      to_train_station_timetable(Ekispert::Client.get('operationLine/timetable', params))
    end

    def self.to_train_station_timetable(elem_arr)
      elem_arr.xpath('//TimeTable').map { |elem| self.new(elem) }
    end

    class Datetime < EkispertBase; end

    private_class_method :to_train_station_timetable

    private

    # This method relate TrainStationTimetable::HourTable::MinuteTable::Stop instance
    # to TrailTimeTable::LineXxx instance.
    # Ex.
    #  TrainStationTimetable::HourTable::MinuteTable::Stop#line_kind
    #  TrainStationTimetable::HourTable::MinuteTable::Stop#line_name
    #  TrainStationTimetable::HourTable::MinuteTable::Stop#line_destination
    def relate_stop_to_line
      @hour_table_list.each do |hour_table|
        hour_table.minute_table_list.each do |minute_table|
          stop = minute_table.stop
          stop.line_kind = @line_kind_list.find { |kind| stop.kind_code == kind.code }
          stop.line_name = @line_name_list.find { |name| stop.name_code == name.code }
          stop.line_destination = @line_destination_list.find { |destination| stop.destination_code == destination.code }
        end
      end
    end
  end
end
