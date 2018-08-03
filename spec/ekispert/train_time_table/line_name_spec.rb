require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::TrainTimeTable::LineName do
  include Ekispert::SpecHelper::Config
  include UtilHelper

  let(:xml) { read_xml('train_time_table/yamagata_shinkansen_from_tokyo.xml') }
  let(:parsed_xml) { Ekispert::Client.send(:parse_xml, xml) }
  let(:train_time_table_list) { Ekispert::TrainTimeTable.send(:to_train_time_table, parsed_xml) }
  let(:line_name) { train_time_table_list[0].line_name_list[0] }
  context 'Tokyo station (only stationCode)' do
    describe '#mark_list' do
      it 'return Array, contains TrainTimeTable::LineName::Mark instance' do
        expect(line_name.mark_list[0].class).to eq Ekispert::TrainTimeTable::LineName::Mark
      end
    end
  end
end
