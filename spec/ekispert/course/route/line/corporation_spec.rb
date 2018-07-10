require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::Course::Route::Line::Corporation do
  include UtilHelper

  let(:xml) { read_xml('course/shinkansen_search.xml') }
  let(:parsed_xml) { Ekispert::Client.send(:parse_xml, xml) }
  let(:course_list) { Ekispert::Course.send(:to_course, parsed_xml) }
  let(:corporation) { course_list[0].route_list[0].line_list[0].corporation_list[0] }

  describe '#name_list' do
    it 'return Array and contains Course::Route::Line::Corporation::Name instance' do
      expect(corporation.name_list[0].class).to eq Ekispert::Course::Route::Line::Corporation::Name
    end
  end
  describe '#name' do
    it 'should return correct value' do
      expect(corporation.name).to eq 'ＪＲ'
    end
  end
end
