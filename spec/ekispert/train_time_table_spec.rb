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
end
