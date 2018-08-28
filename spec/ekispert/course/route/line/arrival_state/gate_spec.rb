# require 'spec_helper'
# require 'helper/util_helper'
#
# RSpec.describe Ekispert::Course::Route::Line::ArrivalState::Gate do
#   include UtilHelper
#
#   let(:xml) { read_xml('course/simple_search.xml') }
#   let(:parsed_xml) { Ekispert::Client.send(:parse_xml, xml) }
#   let(:course_list) { Ekispert::Course.send(:to_course, parsed_xml) }
#   let(:gate) { course_list[0].route_list[0].line_list[0].arrival_state_list[0].gate_list[0] }
#
#   describe '#geopoint_list' do
#     it 'return Array and contains Course::Route::Line::ArrivalState::Gate::GeoPoint instance' do
#       expect(gate.geopoint_list[0].class).to eq Ekispert::Course::Route::Line::ArrivalState::Gate::GeoPoint
#     end
#   end
#   describe '#name_list' do
#     it 'return Array and contains Course::Route::Line::ArrivalState::Gate::Name instance' do
#       expect(gate.name_list[0].class).to eq Ekispert::Course::Route::Line::ArrivalState::Gate::Name
#     end
#   end
# end
#
# This class is only used for route search using data created using '/toolbox/course/point' API.
# This feature has not been implemented yet.
