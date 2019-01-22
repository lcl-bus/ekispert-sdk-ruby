require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::TrainStationTimetable::Information do
  include Ekispert::SpecHelper::Config
  include UtilHelper

  let(:xml) { read_xml('train_station_timetable/yamagata_shinkansen_from_tokyo.xml') }
  let(:parsed_xml) { Ekispert::Client.send(:parse_xml, xml) }
  let(:train_station_timetable_list) { Ekispert::TrainStationTimetable.send(:to_train_station_timetable, parsed_xml) }
  let(:information) { train_station_timetable_list[0].information_list[0] }
  context 'Tokyo station（addTrainInformation=true）' do
    describe '#line_list' do
      it 'return Array, contains TrainStationTimetable::Information::Line instance' do
        expect(information.line_list[0].class).to eq Ekispert::TrainStationTimetable::Information::Line
      end
    end
    describe '#type_list' do
      it 'return Array, contains TrainStationTimetable::Information::Type instance' do
        expect(information.type_list[0].class).to eq Ekispert::TrainStationTimetable::Information::Type
      end
    end
    describe '#type' do
      it 'should return "train"' do
        expect(information.type).to eq 'train'
      end
    end
  end
end
