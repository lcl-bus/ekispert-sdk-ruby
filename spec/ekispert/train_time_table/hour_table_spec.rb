require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::TrainTimeTable::HourTable do
  include Ekispert::SpecHelper::Config
  include UtilHelper

  let(:xml) { read_xml('train_time_table/yamagata_shinkansen_from_tokyo.xml') }
  let(:parsed_xml) { Ekispert::Client.send(:parse_xml, xml) }
  let(:train_time_table_list) { Ekispert::TrainTimeTable.send(:to_train_time_table, parsed_xml) }
  let(:hour_table) { train_time_table_list[0].hour_table_list[0] }
  context 'Tokyo station (only stationCode)' do
    describe '#hour_list' do
      it 'return Array, contains TrainTimeTable::HourTable::Hour instance' do
        expect(hour_table.hour_list[0].class).to eq Ekispert::TrainTimeTable::HourTable::Hour
      end
    end
    describe '#minute_table_list' do
      it 'return Array, contains TrainTimeTable::HourTable::MinuteTable instance' do
        expect(hour_table.minute_table_list[0].class).to eq Ekispert::TrainTimeTable::HourTable::MinuteTable
      end
    end
    describe '#time_reliability_list' do
      it 'return Array, contains TrainTimeTable::HourTable::TimeReliability instance' do
        expect(hour_table.time_reliability_list[0].class).to eq Ekispert::TrainTimeTable::HourTable::TimeReliability
      end
    end
    describe '#pre_cautional_comment_list' do
      it 'return Array, contains TrainTimeTable::HourTable::PreCautionalComment instance' do
        expect(hour_table.pre_cautional_comment_list[0].class).to eq Ekispert::TrainTimeTable::HourTable::PreCautionalComment
      end
    end
  end
end
