require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::Course::Route::Point::Station do
  include UtilHelper

  let(:xml) { read_xml('course/simple_search.xml') }
  let(:parsed_xml) { Ekispert::Client.send(:parse_xml, xml) }
  let(:course_list) { Ekispert::Course.send(:to_course, parsed_xml) }
  let(:station) { course_list[0].route_list[0].point_list[0].station_list[0] }

  describe '#name_list' do
    it 'return Array and contains Course::Route::Point::Station::Name instance' do
      expect(station.name_list[0].class).to eq Ekispert::Course::Route::Point::Station::Name
    end
  end
  describe '#type_list' do
    it 'return Array and contains Course::Route::Point::Station::Type instance' do
      expect(station.type_list[0].class).to eq Ekispert::Course::Route::Point::Station::Type
    end
  end
  describe '#yomi_list' do
    it 'return Array and contains Course::Route::Point::Station::Yomi instance' do
      expect(station.yomi_list[0].class).to eq Ekispert::Course::Route::Point::Station::Yomi
    end
  end
  describe '#name' do
    it 'should return correct value' do
      expect(station.name).to eq '東京'
    end
  end
  describe '#type' do
    it 'should return correct value' do
      expect(station.type).to eq 'train'
    end
  end
  describe '#yomi' do
    it 'should return correct value' do
      expect(station.yomi).to eq 'とうきょう'
    end
  end
end
