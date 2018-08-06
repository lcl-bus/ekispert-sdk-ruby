require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::TrainStationTimetable::Line do
  include Ekispert::SpecHelper::Config
  include UtilHelper

  let(:xml) { read_xml('train_station_timetable/yamagata_shinkansen_from_tokyo.xml') }
  let(:parsed_xml) { Ekispert::Client.send(:parse_xml, xml) }
  let(:train_station_timetable_list) { Ekispert::TrainStationTimetable.send(:to_train_station_timetable, parsed_xml) }
  let(:line) { train_station_timetable_list[0].line_list[0] }
  context 'Tokyo station (only stationCode)' do
    describe '#name_list' do
      it 'return Array, contains TrainStationTimetable::Line::Name instance' do
        expect(line.name_list[0].class).to eq Ekispert::TrainStationTimetable::Line::Name
      end
    end
    describe '#direction_list' do
      it 'return Array, contains TrainStationTimetable::Line::Direction instance' do
        expect(line.direction_list[0].class).to eq Ekispert::TrainStationTimetable::Line::Direction
      end
    end
    describe '#source_list' do
      it 'return Array, contains TrainStationTimetable::Line::Source instance' do
        expect(line.source_list[0].class).to eq Ekispert::TrainStationTimetable::Line::Source
      end
    end
    describe '#color_list' do
      it 'return Array, contains TrainStationTimetable::Line::Color instance' do
        expect(line.color_list[0].class).to eq Ekispert::TrainStationTimetable::Line::Color
      end
    end
    describe '#name' do
      it 'should return "ＪＲ山形新幹線"' do
        expect(line.name).to eq 'ＪＲ山形新幹線'
      end
    end
    describe '#direction' do
      it 'should return "山形・新庄"' do
        expect(line.direction).to eq '山形・新庄'
      end
    end
    describe '#source' do
      it 'should return "東京"' do
        expect(line.source).to eq '東京'
      end
    end
    describe '#color' do
      it 'should return "201201201"' do
        expect(line.color).to eq '201201201'
      end
    end
  end
end
