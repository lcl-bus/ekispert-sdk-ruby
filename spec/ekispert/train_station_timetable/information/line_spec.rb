require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::TrainStationTimetable::Information::Line do
  include Ekispert::SpecHelper::Config
  include UtilHelper

  let(:xml) { read_xml('train_station_timetable/yamagata_shinkansen_from_tokyo.xml') }
  let(:parsed_xml) { Ekispert::Client.send(:parse_xml, xml) }
  let(:train_station_timetable_list) { Ekispert::TrainStationTimetable.send(:to_train_station_timetable, parsed_xml) }
  let(:line) { train_station_timetable_list[0].information_list[0].line_list[0] }
  context 'Tokyo station（addTrainInformation=true）' do
    describe '#name_list' do
      it 'return Array, contains TrainStationTimetable::Information::Line::Name instance' do
        expect(line.name_list[0].class).to eq Ekispert::TrainStationTimetable::Information::Line::Name
      end
    end
    describe '#guide_comment_list' do
      it 'return Array, contains TrainStationTimetable::Information::Line::GuideComment instance' do
        expect(line.guide_comment_list[0].class).to eq Ekispert::TrainStationTimetable::Information::Line::GuideComment
      end
    end
    describe '#type_list' do
      it 'return Array, contains TrainStationTimetable::Information::Line::Type instance' do
        expect(line.type_list[0].class).to eq Ekispert::TrainStationTimetable::Information::Line::Type
      end
    end
    describe '#drive_comment_list' do
      it 'return Array, contains TrainStationTimetable::Information::Line::DriveComment instance' do
        expect(line.drive_comment_list[0].class).to eq Ekispert::TrainStationTimetable::Information::Line::DriveComment
      end
    end
  end
end
