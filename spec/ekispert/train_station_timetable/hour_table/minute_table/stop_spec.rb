require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::TrainStationTimetable::HourTable::MinuteTable::Stop do
  include Ekispert::SpecHelper::Config
  include UtilHelper

  let(:xml) { read_xml('train_station_timetable/yamagata_shinkansen_from_tokyo.xml') }
  let(:parsed_xml) { Ekispert::Client.send(:parse_xml, xml) }
  let(:train_station_timetable_list) { Ekispert::TrainStationTimetable.send(:to_train_station_timetable, parsed_xml) }
  let(:stop) { train_station_timetable_list[0].hour_table_list[0].minute_table_list[0].stop_list[0] }
  context 'Tokyo station (only stationCode)' do
    describe '#number_list' do
      it 'return Array, contains TrainStationTimetable::HourTable::MinuteTable::Stop::Number instance' do
        expect(stop.number_list[0].class).to eq Ekispert::TrainStationTimetable::HourTable::MinuteTable::Stop::Number
      end
    end
    describe '#number' do
      it 'should return "120"' do
        expect(stop.number).to eq '120'
      end
    end
    describe '#line_kind' do
      it 'should return TrainStationTimetable::LineKind instance' do
        expect(stop.line_kind.class).to eq Ekispert::TrainStationTimetable::LineKind
      end
      it 'can call #text, return correct value' do
        expect(stop.line_kind.text).to eq 'つばさ'
      end
    end
    describe '#line_name' do
      it 'should return TrainStationTimetable::LineName instance' do
        expect(stop.line_name.class).to eq Ekispert::TrainStationTimetable::LineName
      end
      it 'can call #mark, return correct value' do
        expect(stop.line_name.mark).to eq 'つ'
      end
    end
    describe '#line_destination' do
      it 'should return TrainStationTimetable::LineDestination instance' do
        expect(stop.line_destination.class).to eq Ekispert::TrainStationTimetable::LineDestination
      end
      it 'can call #mark, return correct value' do
        expect(stop.line_destination.mark).to eq '新'
      end
    end
  end
end
