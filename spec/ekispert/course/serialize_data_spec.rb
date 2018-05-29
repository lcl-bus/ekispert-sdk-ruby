require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::Course::SerializeData do
  include UtilHelper

  describe '.to_course（SerializeData class part）' do
    # From: Tokyo, To: Chiba
    let(:xml) { read_xml('course/simple_search.xml') }
    let(:parsed_xml) { Ekispert::Client.send(:parse_xml, xml) }
    let(:course_list) { Ekispert::Course.send(:to_course, parsed_xml) }
    describe 'Course#serialize_data_list' do
      it 'return Array and contains Course::SerializeData instance' do
        expect(course_list[0].serialize_data_list[0].class).to eq Ekispert::Course::SerializeData
      end
    end
  end
end
