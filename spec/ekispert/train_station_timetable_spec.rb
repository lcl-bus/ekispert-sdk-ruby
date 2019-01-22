require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::TrainStationTimetable do
  include Ekispert::SpecHelper::Config
  include UtilHelper

  describe '.get' do
    before { set_ekispert_default_config }
    context 'params only stationCode' do
      let(:time_table_list) { Ekispert::TrainStationTimetable.get(stationCode: '22828') }
      it 'return Array, contains Ekispert::TrainStationTimetable instances' do
        expect(time_table_list[0].class).to eq Ekispert::TrainStationTimetable
      end
    end
  end
  describe '.to_train_station_timetable' do
    let(:xml) { read_xml('train_station_timetable/tokyo_time_table.xml') }
    let(:parsed_xml) { Ekispert::Client.send(:parse_xml, xml) }
    let(:train_station_timetable_list) { Ekispert::TrainStationTimetable.send(:to_train_station_timetable, parsed_xml) }
    let(:train_station_timetable) { train_station_timetable_list[0] }
    context 'Tokyo station (only stationCode)' do
      describe '#station_list' do
        it 'return Array, contains TrainStationTimetable::Station instance' do
          expect(train_station_timetable.station_list[0].class).to eq Ekispert::TrainStationTimetable::Station
        end
      end
    end
    context 'Tokyo station (Yamagata Shinkansen)' do
      let(:xml) { read_xml('train_station_timetable/yamagata_shinkansen_from_tokyo.xml') }
      describe '#hour_table_list' do
        it 'return Array, contains TrainStationTimetable::HourTable instance' do
          expect(train_station_timetable.hour_table_list[0].class).to eq Ekispert::TrainStationTimetable::HourTable
        end
      end
      describe '#line_list' do
        it 'return Array, contains TrainStationTimetable::Line instance' do
          expect(train_station_timetable.line_list[0].class).to eq Ekispert::TrainStationTimetable::Line
        end
      end
      describe '#line_name_list' do
        it 'return Array, contains TrainStationTimetable::LineName instance' do
          expect(train_station_timetable.line_name_list[0].class).to eq Ekispert::TrainStationTimetable::LineName
        end
      end
      describe '#line_kind_list' do
        it 'return Array, contains TrainStationTimetable::LineKind instance' do
          expect(train_station_timetable.line_kind_list[0].class).to eq Ekispert::TrainStationTimetable::LineKind
        end
      end
      describe '#line_destination_list' do
        it 'return Array, contains TrainStationTimetable::LineDestination instance' do
          expect(train_station_timetable.line_destination_list[0].class).to eq Ekispert::TrainStationTimetable::LineDestination
        end
      end
      describe '#information_list' do
        it 'return Array, contains TrainStationTimetable::Information instance' do
          expect(train_station_timetable.information_list[0].class).to eq Ekispert::TrainStationTimetable::Information
        end
      end
      describe '#datetime_list' do
        it 'return Array, contains TrainStationTimetable::Datetime instance' do
          expect(train_station_timetable.datetime_list[0].class).to eq Ekispert::TrainStationTimetable::Datetime
        end
      end
      describe '#station' do
        it 'sould return TrainStationTimetable::Station instance' do
          expect(train_station_timetable.station.class).to eq Ekispert::TrainStationTimetable::Station
        end
      end
      describe '#datetime' do
        it 'sould return TrainStationTimetable::Datetime instance' do
          expect(train_station_timetable.datetime.class).to eq Ekispert::TrainStationTimetable::Datetime
        end
      end
      describe '#line' do
        it 'sould return TrainStationTimetable::Line instance' do
          expect(train_station_timetable.line.class).to eq Ekispert::TrainStationTimetable::Line
        end
      end
    end
  end
end
