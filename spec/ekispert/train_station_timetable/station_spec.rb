require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::TrainStationTimetable::Station do
  include Ekispert::SpecHelper::Config
  include UtilHelper

  let(:xml) { read_xml('train_station_timetable/tokyo_time_table.xml') }
  let(:parsed_xml) { Ekispert::Client.send(:parse_xml, xml) }
  let(:train_station_timetable_list) { Ekispert::TrainStationTimetable.send(:to_train_station_timetable, parsed_xml) }
  let(:station) { train_station_timetable_list[0].station_list[0] }
  context 'Tokyo station (only stationCode)' do
    describe '#name_list' do
      it 'return Array, contains TrainStationTimetable::Station::Name instance' do
        expect(station.name_list[0].class).to eq Ekispert::TrainStationTimetable::Station::Name
      end
    end
    describe '#name' do
      it 'should return "東京"' do
        expect(station.name).to eq '東京'
      end
    end
  end
end
