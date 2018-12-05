require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::TrainStationTimetable::HourTable::MinuteTable do
  include Ekispert::SpecHelper::Config
  include UtilHelper

  let(:xml) { read_xml('train_station_timetable/yamagata_shinkansen_from_tokyo.xml') }
  let(:parsed_xml) { Ekispert::Client.send(:parse_xml, xml) }
  let(:train_station_timetable_list) { Ekispert::TrainStationTimetable.send(:to_train_station_timetable, parsed_xml) }
  let(:minute_table) { train_station_timetable_list[0].hour_table_list[0].minute_table_list[0] }
  context 'Tokyo station (only stationCode)' do
    describe '#minute_list' do
      it 'return Array, contains TrainStationTimetable::HourTable::MinuteTable::Minute instance' do
        expect(minute_table.minute_list[0].class).to eq Ekispert::TrainStationTimetable::HourTable::MinuteTable::Minute
      end
    end
    describe '#stop_list' do
      it 'return Array, contains TrainStationTimetable::HourTable::MinuteTable::Stop instance' do
        expect(minute_table.stop_list[0].class).to eq Ekispert::TrainStationTimetable::HourTable::MinuteTable::Stop
      end
    end
  end
end
