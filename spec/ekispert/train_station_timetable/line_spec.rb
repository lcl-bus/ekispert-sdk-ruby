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
  end
end
