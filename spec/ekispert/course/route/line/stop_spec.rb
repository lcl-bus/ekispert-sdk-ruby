require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::Course::Route::Line::Stop do
  include UtilHelper

  let(:xml) { read_xml('course/add_stop_station.xml') }
  let(:parsed_xml) { Ekispert::Client.send(:parse_xml, xml) }
  let(:course_list) { Ekispert::Course.send(:to_course, parsed_xml) }
  let(:stop_list) { course_list[0].route_list[0].line_list[0].stop_list }

  describe '#point_list' do
    it 'should return Array and contains Course::Route::Line::Stop::Point instance' do
      expect(stop_list[0].point_list[0].class).to eq Ekispert::Course::Route::Line::Stop::Point
    end
  end
  describe '#departure_state_list' do
    it 'should return Array and contains Course::Route::Line::Stop::DepartureState instance' do
      expect(stop_list[0].departure_state_list[0].class).to eq Ekispert::Course::Route::Line::Stop::DepartureState
    end
  end
  describe '#arrival_state_list' do
    it 'should return Array and contains Course::Route::Line::Stop::ArrivalState instance' do
      expect(stop_list[0].arrival_state_list[0].class).to eq Ekispert::Course::Route::Line::Stop::ArrivalState
    end
  end
end
