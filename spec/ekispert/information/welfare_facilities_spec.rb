require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::Information::WelfareFacilities do
  include UtilHelper

  describe '.to_information（WelfareFacilities class part）' do
    context 'use information/all_type_search.xml' do
      let(:parsed_xml) { Ekispert::Client.send(:parse_xml, read_xml('information/all_type_search.xml')) }
      let(:information_list) { Ekispert::Information.send(:to_information, parsed_xml) }
      describe 'Ekispert::Information::WelfareFacilities instance' do
        describe '#name_list' do
          it 'contains Ekispert::Information::WelfareFacilities::Name instance' do
            expect(information_list[3].welfare_facilities_list[0].name_list[0].class).to eq Ekispert::Information::WelfareFacilities::Name
          end
        end
        describe '#comment_list' do
          it 'contains Ekispert::Information::WelfareFacilities::Comment instance' do
            expect(information_list[3].welfare_facilities_list[0].comment_list[0].class).to eq Ekispert::Information::WelfareFacilities::Comment
          end
        end
        describe '#name' do
          it 'should return "エスカレータ"' do
            expect(information_list[3].welfare_facilities_list[2].name).to eq 'エスカレータ'
          end
        end
        describe '#comment' do
          it 'should return "・改札⇔出口方面"' do
            expect(information_list[3].welfare_facilities_list[2].comment).to eq '・改札⇔出口方面'
          end
        end
      end
    end
  end
end
