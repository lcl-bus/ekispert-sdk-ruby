require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::Course::Route::Point do
  include UtilHelper

  let(:xml) { read_xml('course/simple_search.xml') }
  let(:parsed_xml) { Ekispert::Client.send(:parse_xml, xml) }
  let(:course_list) { Ekispert::Course.send(:to_course, parsed_xml) }
  let(:point) { course_list[0].route_list[0].point_list[0] }

  describe '#station_list' do
    it 'return Array and contains Course::Route::Point::Station instance' do
      expect(point.station_list[0].class).to eq Ekispert::Course::Route::Point::Station
    end
  end
  describe '#prefecture_list' do
    it 'return Array and contains Course::Route::Point::Prefecture instance' do
      expect(point.prefecture_list[0].class).to eq Ekispert::Course::Route::Point::Prefecture
    end
  end
  describe '#geopoint_list' do
    it 'return Array and contains Course::Route::Point::GeoPoint instance' do
      expect(point.geo_point_list[0].class).to eq Ekispert::Course::Route::Point::GeoPoint
    end
  end
  describe '#name_list' do
    let(:xml) { read_xml('course/geo_point_search.xml') }
    it 'return Array and contains Course::Route::Point::Name instance' do
      expect(point.name_list[0].class).to eq Ekispert::Course::Route::Point::Name
    end
  end
  describe '#station' do
    it 'can call #code, return correct value' do
      expect(point.station.code).to eq '22828'
    end
  end
  describe '#prefecture' do
    it 'can call #code, return correct value' do
      expect(point.prefecture.code).to eq '13'
    end
  end
  describe '#geopoint' do
    it 'can call #longi, return correct value' do
      expect(point.geo_point.longi).to eq '139.46.13.59'
    end
  end
  describe '#name' do
    let(:xml) { read_xml('course/geo_point_search.xml') }
    it 'should return correct value' do
      expect(point.name).to eq '35.695611594915164,139.7578486511294,wgs84'
    end
  end
  describe '#station?' do
    context 'Point type Station' do
      it 'should return true' do
        expect(point.station?).to be true
      end
    end
    context 'Point type Geopoint' do
      let(:xml) { read_xml('course/geo_point_search.xml') }
      it 'should return false' do
        expect(point.station?).to be false
      end
    end
  end
end
