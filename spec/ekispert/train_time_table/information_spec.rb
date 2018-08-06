require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::TrainTimeTable::Information do
  include Ekispert::SpecHelper::Config
  include UtilHelper

  let(:xml) { read_xml('train_time_table/yamagata_shinkansen_from_tokyo.xml') }
  let(:parsed_xml) { Ekispert::Client.send(:parse_xml, xml) }
  let(:train_time_table_list) { Ekispert::TrainTimeTable.send(:to_train_time_table, parsed_xml) }
  let(:information) { train_time_table_list[0].information_list[0] }
  context 'Tokyo station（addTrainInformation=true）' do
    describe '#line_list' do
      it 'return Array, contains TrainTimeTable::Information::Line instance' do
        expect(information.line_list[0].class).to eq Ekispert::TrainTimeTable::Information::Line
      end
    end
    describe '#type_list' do
      it 'return Array, contains TrainTimeTable::Information::Type instance' do
        expect(information.type_list[0].class).to eq Ekispert::TrainTimeTable::Information::Type
      end
    end
  end
end
