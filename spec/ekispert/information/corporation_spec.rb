require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::Information::Corporation do
  include UtilHelper

  describe '.to_information（Corporation class part）' do
    context 'use information/all_type_search.xml' do
      let(:parsed_xml) { Ekispert::Client.send(:parse_xml, read_xml('information/all_type_search.xml')) }
      let(:information_list) { Ekispert::Information.send(:to_information, parsed_xml) }
      let(:corporation) { information_list[0].corporation_list[0] }
      describe 'Ekispert::Information::Corporation instance' do
        describe '#name_list' do
          it 'contains Ekispert::Information::Corporation::Name instance' do
            expect(corporation.name_list[0].class).to eq Ekispert::Information::Corporation::Name
          end
        end
        describe '#line_list' do
          let(:corporation) { information_list[0].corporation_list[1] }
          it 'contains Ekispert::Information::Corporation instance' do
            expect(corporation.line_list[0].class).to eq Ekispert::Information::Line
          end
          describe '#name' do
            it 'should return "東京メトロ千代田線"' do
              expect(corporation.line_list[0].name).to eq '東京メトロ千代田線'
            end
          end
          describe '#type' do
            it 'should return "train"' do
              expect(corporation.line_list[0].type).to eq 'train'
            end
          end
          describe '#color' do
            let(:corporation) { information_list[0].corporation_list[0] }
            it 'should return "013087206"' do
              expect(corporation.line_list[1].color).to eq '013087206'
            end
          end
        end
      end
    end
  end
end
