require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::Information::Corporation do
  include UtilHelper

  describe '.to_information（Corporation class part）' do
    context 'use information/all_type_search.xml' do
      let(:parsed_xml) { Ekispert::Client.send(:parse_xml, read_xml('information/all_type_search.xml')) }
      let(:information_list) { Ekispert::Information.send(:to_information_class, parsed_xml) }
      let(:corporation) { information_list[0].corporation_list[0] }
      describe 'Ekispert::Information::Corporation instance' do
        describe '#name_list' do
          it 'contains Ekispert::Information::Corporation::Name instance' do
            expect(corporation.name_list[0].class).to eq Ekispert::Information::Corporation::Name
          end
        end
      end
    end
  end
end
