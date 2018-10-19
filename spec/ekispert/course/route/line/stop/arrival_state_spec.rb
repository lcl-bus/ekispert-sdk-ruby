require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::Course::Route::Line::Stop::ArrivalState do
  include UtilHelper

  let(:xml) { read_xml('course/add_stop_station.xml') }
  let(:parsed_xml) { Ekispert::Client.send(:parse_xml, xml) }
  let(:course_list) { Ekispert::Course.send(:to_course, parsed_xml) }
  let(:arrival_state) { course_list[0].route_list[0].line_list[0].stop_list[0].arrival_state_list[0] }

  describe '#datetime_list' do
    it 'should return Array and contains Course::Route::Line::Stop::ArrivalState::Datetime instance' do
      expect(arrival_state.datetime_list[0].class).to eq Ekispert::Course::Route::Line::Stop::ArrivalState::Datetime
    end
  end
  describe '#datetime' do
    it 'should return correct value' do
      expect(arrival_state.datetime.strftime('%Y年%02m月%02d日 %H:%M:%S')).to eq '2018年10月05日 12:57:00'
    end
  end
end
