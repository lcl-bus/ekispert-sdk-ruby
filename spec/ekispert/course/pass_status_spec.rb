require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::Course::PassStatus do
  include UtilHelper

  describe '.to_course（PassStatus class part）' do
    # From: Tokyo, To: Chiba
    let(:xml) { read_xml('course/simple_search.xml') }
    let(:parsed_xml) { Ekispert::Client.send(:parse_xml, xml) }
    let(:course_list) { Ekispert::Course.send(:to_course, parsed_xml) }
    let(:pass_status) { course_list[1].pass_status_list[0] }
    describe 'Course::PassStatus instance' do
      describe '#comment_list' do
        it 'return Array and contains Course::PassStatus::Comment instance' do
          expect(pass_status.comment_list[0].class).to eq Ekispert::Course::PassStatus::Comment
        end
      end
      describe '#name_list' do
        it 'return Array and contains Course::PassStatus::Name instance' do
          expect(pass_status.name_list[0].class).to eq Ekispert::Course::PassStatus::Name
        end
      end
      describe '#type_list' do
        it 'return Array and contains Course::PassStatus::Type instance' do
          expect(pass_status.type_list[0].class).to eq Ekispert::Course::PassStatus::Type
        end
      end
    end
  end
end
