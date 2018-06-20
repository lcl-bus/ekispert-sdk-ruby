require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::Information do
  include Ekispert::SpecHelper::Config
  include UtilHelper

  describe '.get' do
    before { set_ekispert_default_config }
    context 'params = { code: 22828, type: "rail" }' do
      let(:information_list) { Ekispert::Information.get(code: 22828, type: 'rail') }
      it 'return Array contain Ekispert::Information instance' do
        expect(information_list[0].class).to eq Ekispert::Information
      end
      describe 'Ekispert::Information#type' do
        it 'should return "rail"' do
          expect(information_list[0].type).to eq 'rail'
        end
      end
    end
  end
  describe '.to_information_class' do
    describe 'Ekispert::Information instance' do
      context 'use information/all_type_search.xml' do
        let(:parsed_xml) { Ekispert::Client.send(:parse_xml, read_xml('information/all_type_search.xml')) }
        let(:information_list) { Ekispert::Information.send(:to_information_class, parsed_xml) }
        context '#type == "rail"' do
          let(:information) { information_list[0] }
          describe '#line_list' do
            it 'contain Ekispert::Information::Line instance' do
              expect(information.line_list[0].class).to eq Ekispert::Information::Line
            end
          end
          describe '#corporation_list' do
            it 'contain Ekispert::Information::Corporation instance' do
              expect(information.corporation_list[0].class).to eq Ekispert::Information::Corporation
            end
          end
          describe '#exit_list' do
            it 'empty' do
              expect(information.exit_list).to be_empty
            end
          end
          describe '#welfare_facilities_list' do
            it 'empty' do
              expect(information.welfare_facilities_list).to be_empty
            end
          end
        end
        context '#type == "exit"' do
          let(:information) { information_list[2] }
          describe '#exit_list' do
            it 'contain Ekispert::Information::Exit' do
              expect(information.exit_list[0].class).to eq Ekispert::Information::Exit
            end
          end
        end
        context '#type == "welfare"' do
          let(:information) { information_list[3] }
          describe '#welfare_facilities_list' do
            it 'contain Ekispert::Information::WelfareFacilities' do
              expect(information.welfare_facilities_list[0].class).to eq Ekispert::Information::WelfareFacilities
            end
          end
        end
      end
    end
  end
end
