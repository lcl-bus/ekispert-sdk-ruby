require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::TrainTimeTable do
  include Ekispert::SpecHelper::Config
  include UtilHelper

  describe '.get' do
    before { set_ekispert_default_config }
    context 'params only stationCode' do
      let(:time_table_list) { Ekispert::TrainTimeTable.get(stationCode: '22828') }
      it 'return Array, contains Ekispert::TrainTimeTable instances' do
        expect(time_table_list[0].class).to eq Ekispert::TrainTimeTable
      end
    end
  end
  describe '.to_train_time_table' do
    let(:xml) { read_xml('train_time_table/tokyo_time_table.xml') }
    let(:parsed_xml) { Ekispert::Client.send(:parse_xml, xml) }
    let(:train_time_table_list) { Ekispert::TrainTimeTable.send(:to_train_time_table, parsed_xml) }
    let(:train_time_table) { train_time_table_list[0] }
    context 'Tokyo station (only stationCode)' do
      describe '#station_list' do
        it 'return Array, contains TrainTimeTable::Station instance' do
          expect(train_time_table.station_list[0].class).to eq Ekispert::TrainTimeTable::Station
        end
      end
    end
  end
end
