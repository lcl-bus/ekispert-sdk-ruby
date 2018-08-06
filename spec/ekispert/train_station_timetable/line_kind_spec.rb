require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::TrainStationTimetable::LineKind do
  include Ekispert::SpecHelper::Config
  include UtilHelper

  let(:xml) { read_xml('train_station_timetable/yamagata_shinkansen_from_tokyo.xml') }
  let(:parsed_xml) { Ekispert::Client.send(:parse_xml, xml) }
  let(:train_station_timetable_list) { Ekispert::TrainStationTimetable.send(:to_train_station_timetable, parsed_xml) }
  let(:line_kind) { train_station_timetable_list[0].line_kind_list[0] }
  context 'Tokyo station (only stationCode)' do
    describe '#mark_list' do
      it 'return Array, contains TrainStationTimetable::LineKind::Mark instance' do
        expect(line_kind.mark_list[0].class).to eq Ekispert::TrainStationTimetable::LineKind::Mark
      end
    end
    describe '#mark' do
      it 'should return ""' do
        expect(line_kind.mark).to eq ''
      end
    end
  end
end
