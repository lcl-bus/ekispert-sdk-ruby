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
  describe '#departure_point' do
    it 'should return the first departure point' do
      expect(route.departure_point.station.name).to eq '東京'
    end
  end
  describe '#arrival_point' do
    it 'should return the last arrival point' do
      expect(route.arrival_point.station.name).to eq '千葉'
    end
  end
  describe '#departure_time' do
    it 'should return the first departure time' do
      expect(route.departure_time.strftime('%Y年%02m月%02d日 %H:%M:%S')).to eq '2018年06月06日 15:18:00'
    end
  end
  describe '#arrival_time' do
    it 'should return the last arrival time' do
      expect(route.arrival_time.strftime('%Y年%02m月%02d日 %H:%M:%S')).to eq '2018年06月06日 16:05:00'
    end
  end
end
