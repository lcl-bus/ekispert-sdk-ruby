require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::TrainTimeTable::Line do
  include Ekispert::SpecHelper::Config
  include UtilHelper

  let(:xml) { read_xml('train_time_table/yamagata_shinkansen_from_tokyo.xml') }
  let(:parsed_xml) { Ekispert::Client.send(:parse_xml, xml) }
  let(:train_time_table_list) { Ekispert::TrainTimeTable.send(:to_train_time_table, parsed_xml) }
  let(:line) { train_time_table_list[0].line_list[0] }
  context 'Tokyo station (only stationCode)' do
    describe '#name_list' do
      it 'return Array, contains TrainTimeTable::Line::Name instance' do
        expect(line.name_list[0].class).to eq Ekispert::TrainTimeTable::Line::Name
      end
    end
    describe '#direction_list' do
      it 'return Array, contains TrainTimeTable::Line::Direction instance' do
        expect(line.direction_list[0].class).to eq Ekispert::TrainTimeTable::Line::Direction
      end
    end
    describe '#source_list' do
      it 'return Array, contains TrainTimeTable::Line::Source instance' do
        expect(line.source_list[0].class).to eq Ekispert::TrainTimeTable::Line::Source
      end
    end
    describe '#color_list' do
      it 'return Array, contains TrainTimeTable::Line::Color instance' do
        expect(line.color_list[0].class).to eq Ekispert::TrainTimeTable::Line::Color
      end
    end
  end
end
