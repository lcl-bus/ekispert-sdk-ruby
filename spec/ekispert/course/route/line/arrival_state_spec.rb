require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::Course::Route::Line::ArrivalState do
  include UtilHelper

  let(:xml) { read_xml('course/simple_search.xml') }
  let(:parsed_xml) { Ekispert::Client.send(:parse_xml, xml) }
  let(:course_list) { Ekispert::Course.send(:to_course, parsed_xml) }
  let(:arrival_state) { course_list[0].route_list[0].line_list[0].arrival_state_list[0] }

  # This class is only used for route search using data created using '/toolbox/course/point' API.
  # This feature has not been implemented yet.
  #
  # describe '#gate_list' do
  #   it 'return Array and contains Course::Route::Line::ArrivalState::Gate instance' do
  #     expect(arrival_state.gate_list[0].class).to eq Ekispert::Course::Route::Line::ArrivalState::Gate
  #   end
  # end
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
  describe '#datetime' do
    it 'return DateTime instance' do
      expect(arrival_state.datetime.class).to eq DateTime
    end
    it 'should return correct value' do
      expect(arrival_state.datetime.strftime('%Y年%02m月%02d日 %H:%M:%S')).to eq '2018年06月06日 15:56:00'
    end
  end
end
