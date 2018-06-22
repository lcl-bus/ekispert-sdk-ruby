require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::Information::Exit do
  include UtilHelper

  describe '.to_information（Exit class part）' do
    context 'use information/all_type_search.xml' do
      let(:parsed_xml) { Ekispert::Client.send(:parse_xml, read_xml('information/all_type_search.xml')) }
      let(:information_list) { Ekispert::Information.send(:to_information, parsed_xml) }
      describe 'Ekispert::Information::Exit instance' do
        describe '#name_list' do
          it 'contains Ekispert::Information::Exit::Name instance' do
            expect(information_list[2].exit_list[0].name_list[0].class).to eq Ekispert::Information::Exit::Name
          end
        end
        describe '#comment_list' do
          it 'contains Ekispert::Information::Exit::Comment instance' do
            expect(information_list[2].exit_list[0].comment_list[0].class).to eq Ekispert::Information::Exit::Comment
          end
        end
        describe '#name' do
          it 'should return "東口"' do
            expect(information_list[2].exit_list[0].name).to eq '東口'
          end
        end
        describe '#comment' do
          it 'should return "西原１－３丁目上原１丁目元代々木町"' do
            expect(information_list[2].exit_list[0].comment).to eq '西原１－３丁目上原１丁目元代々木町'
          end
        end
      end
    end
  end
end
