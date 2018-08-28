require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::Course::Route::Line do
  include UtilHelper

  let(:xml) { read_xml('course/simple_search.xml') }
  let(:parsed_xml) { Ekispert::Client.send(:parse_xml, xml) }
  let(:course_list) { Ekispert::Course.send(:to_course, parsed_xml) }
  let(:line) { course_list[0].route_list[0].line_list[0] }

  describe '#name_list' do
    it 'return Array and contains Course::Route::Line::Name instance' do
      expect(line.name_list[0].class).to eq Ekispert::Course::Route::Line::Name
    end
  end
  describe '#type_list' do
    it 'return Array and contains Course::Route::Line::Type instance' do
      expect(line.type_list[0].class).to eq Ekispert::Course::Route::Line::Type
    end
  end
  describe '#destination_list' do
    it 'return Array and contains Course::Route::Line::Destination instance' do
      expect(line.destination_list[0].class).to eq Ekispert::Course::Route::Line::Destination
    end
  end
  describe '#number_list' do
    # From: Tokyo, To: Shin-Osaka
    let(:xml) { read_xml('course/shinkansen_search.xml') }
    it 'return Array and contains Course::Route::Line::Number instance' do
      expect(line.number_list[0].class).to eq Ekispert::Course::Route::Line::Number
    end
  end
  describe '#time_reliability_list' do
    it 'return Array and contains Course::Route::Line::TimeReliability instance' do
      expect(line.time_reliability_list[0].class).to eq Ekispert::Course::Route::Line::TimeReliability
    end
  end
  describe '#color_list' do
    it 'return Array and contains Course::Route::Line::Color instance' do
      expect(line.color_list[0].class).to eq Ekispert::Course::Route::Line::Color
    end
  end
  describe '#arrival_state_list' do
    it 'return Array and contains Course::Route::Line::ArrivalState instance' do
      expect(line.arrival_state_list[0].class).to eq Ekispert::Course::Route::Line::ArrivalState
    end
  end
  describe '#departure_state_list' do
    it 'return Array and contains Course::Route::Line::DepartureState instance' do
      expect(line.departure_state_list[0].class).to eq Ekispert::Course::Route::Line::DepartureState
    end
  end
end
