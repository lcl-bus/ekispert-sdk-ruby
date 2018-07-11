require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::Course::Route::Line::ArrivalState do
  include UtilHelper

  let(:xml) { read_xml('course/simple_search.xml') }
  let(:parsed_xml) { Ekispert::Client.send(:parse_xml, xml) }
  let(:course_list) { Ekispert::Course.send(:to_course, parsed_xml) }
  let(:arrival_state) { course_list[0].route_list[0].line_list[0].arrival_state_list[0] }

  describe '#gate_list' do
    it 'return Array and contains Course::Route::Line::ArrivalState::Gate instance' do
      expect(arrival_state.gate_list[0].class).to eq Ekispert::Course::Route::Line::ArrivalState::Gate
    end
  end
  describe '#type_list' do
    it 'return Array and contains Course::Route::Line::ArrivalState::Type instance' do
      expect(arrival_state.type_list[0].class).to eq Ekispert::Course::Route::Line::ArrivalState::Type
    end
  end
  describe '#datetime_list' do
    it 'return Array and contains Course::Route::Line::ArrivalState::Datetime instance' do
      expect(arrival_state.datetime_list[0].class).to eq Ekispert::Course::Route::Line::ArrivalState::Datetime
    end
  end
end
