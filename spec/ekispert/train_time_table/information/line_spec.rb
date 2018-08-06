require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::TrainTimeTable::Information::Line do
  include Ekispert::SpecHelper::Config
  include UtilHelper

  let(:xml) { read_xml('train_time_table/yamagata_shinkansen_from_tokyo.xml') }
  let(:parsed_xml) { Ekispert::Client.send(:parse_xml, xml) }
  let(:train_time_table_list) { Ekispert::TrainTimeTable.send(:to_train_time_table, parsed_xml) }
  let(:line) { train_time_table_list[0].information_list[0].line_list[0] }
  context 'Tokyo station（addTrainInformation=true）' do
    describe '#name_list' do
      it 'return Array, contains TrainTimeTable::Information::Line::Name instance' do
        expect(line.name_list[0].class).to eq Ekispert::TrainTimeTable::Information::Line::Name
      end
    end
    describe '#guide_comment_list' do
      it 'return Array, contains TrainTimeTable::Information::Line::GuideComment instance' do
        expect(line.guide_comment_list[0].class).to eq Ekispert::TrainTimeTable::Information::Line::GuideComment
      end
    end
    describe '#type_list' do
      it 'return Array, contains TrainTimeTable::Information::Line::Type instance' do
        expect(line.type_list[0].class).to eq Ekispert::TrainTimeTable::Information::Line::Type
      end
    end
    describe '#drive_comment_list' do
      it 'return Array, contains TrainTimeTable::Information::Line::DriveComment instance' do
        expect(line.drive_comment_list[0].class).to eq Ekispert::TrainTimeTable::Information::Line::DriveComment
      end
    end
  end
end
