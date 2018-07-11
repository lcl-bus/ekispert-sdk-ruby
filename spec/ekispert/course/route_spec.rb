require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::Course::Route do
  include UtilHelper

  let(:xml) { read_xml('course/simple_search.xml') }
  let(:parsed_xml) { Ekispert::Client.send(:parse_xml, xml) }
  let(:course_list) { Ekispert::Course.send(:to_course, parsed_xml) }
  let(:route) { course_list[0].route_list[0] }

  describe '#line_list' do
    it 'return Array and contains Course::Route::Line instance' do
      expect(route.line_list[0].class).to eq Ekispert::Course::Route::Line
    end
  end
  describe '#point_list' do
    it 'return Array and contains Course::Route::Point instance' do
      expect(route.point_list[0].class).to eq Ekispert::Course::Route::Point
    end
  end
end
