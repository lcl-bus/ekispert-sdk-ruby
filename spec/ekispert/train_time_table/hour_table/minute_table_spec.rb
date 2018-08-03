require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::TrainTimeTable::HourTable::MinuteTable do
  include Ekispert::SpecHelper::Config
  include UtilHelper

  let(:xml) { read_xml('train_time_table/yamagata_shinkansen_from_tokyo.xml') }
  let(:parsed_xml) { Ekispert::Client.send(:parse_xml, xml) }
  let(:train_time_table_list) { Ekispert::TrainTimeTable.send(:to_train_time_table, parsed_xml) }
  let(:minute_table) { train_time_table_list[0].hour_table_list[0].minute_table_list[0] }
  context 'Tokyo station (only stationCode)' do
    describe '#minute_list' do
      it 'return Array, contains TrainTimeTable::HourTable::MinuteTable::Minute instance' do
        expect(minute_table.minute_list[0].class).to eq Ekispert::TrainTimeTable::HourTable::MinuteTable::Minute
      end
    end
    describe '#stop_list' do
      it 'return Array, contains TrainTimeTable::HourTable::MinuteTable::Stop instance' do
        expect(minute_table.stop_list[0].class).to eq Ekispert::TrainTimeTable::HourTable::MinuteTable::Stop
      end
    end
  end
end
