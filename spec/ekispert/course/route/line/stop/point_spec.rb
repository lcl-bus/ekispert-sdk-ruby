require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::Course::Route::Line::Stop::Point do
  include UtilHelper

  let(:xml) { read_xml('course/add_stop_station.xml') }
  let(:parsed_xml) { Ekispert::Client.send(:parse_xml, xml) }
  let(:course_list) { Ekispert::Course.send(:to_course, parsed_xml) }
  let(:point) { course_list[0].route_list[0].line_list[0].stop_list[0].point_list[0] }

  describe '#station_list' do
    it 'should return Array and contains Course::Route::Line::Stop::Point::Station instance' do
      expect(point.station_list[0].class).to eq Ekispert::Course::Route::Line::Stop::Point::Station
    end
  end
  describe '#prefecture_list' do
    it 'should return Array and contains Course::Route::Line::Stop::Point::Prefecture instance' do
      expect(point.prefecture_list[0].class).to eq Ekispert::Course::Route::Line::Stop::Point::Prefecture
    end
  end
end
