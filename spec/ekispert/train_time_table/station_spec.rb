require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::TrainTimeTable::Station do
  include Ekispert::SpecHelper::Config
  include UtilHelper

  let(:xml) { read_xml('train_time_table/tokyo_time_table.xml') }
  let(:parsed_xml) { Ekispert::Client.send(:parse_xml, xml) }
  let(:train_time_table_list) { Ekispert::TrainTimeTable.send(:to_train_time_table, parsed_xml) }
  let(:station) { train_time_table_list[0].station_list[0] }
  context 'Tokyo station (only stationCode)' do
    describe '#name_list' do
      it 'return Array, contains TrainTimeTable::Station::Name instance' do
        expect(station.name_list[0].class).to eq Ekispert::TrainTimeTable::Station::Name
      end
    end
  end
end
