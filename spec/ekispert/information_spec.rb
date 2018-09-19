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
  describe '.to_information' do
    describe 'Ekispert::Information instance' do
      context 'use information/all_type_search.xml' do
        let(:parsed_xml) { Ekispert::Client.send(:parse_xml, read_xml('information/all_type_search.xml')) }
        let(:information_list) { Ekispert::Information.send(:to_information, parsed_xml) }
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
          describe '#rail?' do
            context '#type == "rail"' do
              it 'should return true' do
                expect(information.rail?).to be true
              end
            end
          end
          describe '#nearrail?' do
            it 'should return false' do
              expect(information.nearrail?).to be false
            end
          end
        end
        context '#type == "nearail"' do
          let(:information) { information_list[1] }
          describe '#nearail?' do
            it 'should return true' do
              expect(information.nearrail?).to be true
            end
          end
          describe '#exit' do
            it 'should return false' do
              expect(information.exit?).to be false
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
          describe '#exit' do
            it 'should return true' do
              expect(information.exit?).to be true
            end
          end
          describe '#welfare?' do
            it 'should return false' do
              expect(information.welfare?).to be false
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
          describe '#welfare?' do
            it 'should return true' do
              expect(information.welfare?).to be true
            end
          end
          describe '#rail?' do
            it 'should return false' do
              expect(information.rail?).to be false
            end
          end
        end
      end
      context 'use information/empty_type.xml' do
        let(:parsed_xml) { Ekispert::Client.send(:parse_xml, read_xml('information/type_empty.xml')) }
        let(:information_list) { Ekispert::Information.send(:to_information, parsed_xml) }
        it 'should return one Information instance' do
          expect(information_list.size).to eq 1
        end
        describe '#type' do
          it 'should return "rail"' do
            expect(information_list[0].type).to eq 'rail'
          end
        end
      end
    end
  end
end
