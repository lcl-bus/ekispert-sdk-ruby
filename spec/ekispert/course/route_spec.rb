require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::Course::Route do
  include UtilHelper

  describe '.to_course（Route class part）' do
    # From: Tokyo, To: Chiba
    let(:xml) { read_xml('course/simple_search.xml') }
    let(:parsed_xml) { Ekispert::Client.send(:parse_xml, xml) }
    let(:course_list) { Ekispert::Course.send(:to_course, parsed_xml) }
    let(:course) { course_list[0] }
    describe 'Course::Route instance' do
      describe '#line_list' do
        it 'return Array and contains Course::Route::Line instance' do
          expect(course.route_list[0].line_list[0].class).to eq Ekispert::Course::Route::Line
        end
        describe 'Course::Route::Line instance' do
          describe '#name_list' do
            it 'return Array and contains Course::Route::Line::Name instance' do
              expect(course.route_list[0].line_list[0].name_list[0].class).to eq Ekispert::Course::Route::Line::Name
            end
          end
          describe '#type_list' do
            it 'return Array and contains Course::Route::Line::Type instance' do
              expect(course.route_list[0].line_list[0].type_list[0].class).to eq Ekispert::Course::Route::Line::Type
            end
          end
          describe '#destination_list' do
            it 'return Array and contains Course::Route::Line::Destination instance' do
              expect(course.route_list[0].line_list[0].destination_list[0].class).to eq Ekispert::Course::Route::Line::Destination
            end
          end
          describe '#number_list' do
            # From: Tokyo, To: Shin-Osaka
            let(:xml) { read_xml('course/shinkansen_search.xml') }
            it 'return Array and contains Course::Route::Line::Number instance' do
              expect(course.route_list[0].line_list[0].number_list[0].class).to eq Ekispert::Course::Route::Line::Number
            end
          end
          describe '#time_reliability_list' do
            it 'return Array and contains Course::Route::Line::TimeReliability instance' do
              expect(course.route_list[0].line_list[0].time_reliability_list[0].class).to eq Ekispert::Course::Route::Line::TimeReliability
            end
          end
          describe '#color_list' do
            it 'return Array and contains Course::Route::Line::Color instance' do
              expect(course.route_list[0].line_list[0].color_list[0].class).to eq Ekispert::Course::Route::Line::Color
            end
          end
          describe '#arrival_state_list' do
            it 'return Array and contains Course::Route::Line::ArrivalState instance' do
              expect(course.route_list[0].line_list[0].arrival_state_list[0].class).to eq Ekispert::Course::Route::Line::ArrivalState
            end
            describe 'Course::Route::Line::ArrivalState instance' do
              describe '#type_list' do
                it 'return Array and contains Course::Route::Line::ArrivalState::Type instance' do
                  expect(course.route_list[0].line_list[0].arrival_state_list[0].type_list[0].class).to eq Ekispert::Course::Route::Line::ArrivalState::Type
                end
              end
              describe '#datetime_list' do
                it 'return Array and contains Course::Route::Line::ArrivalState::Datetime instance' do
                  expect(course.route_list[0].line_list[0].arrival_state_list[0].datetime_list[0].class).to eq Ekispert::Course::Route::Line::ArrivalState::Datetime
                end
              end
            end
          end
          describe '#departure_state_list' do
            it 'return Array and contains Course::Route::Line::DepartureState instance' do
              expect(course.route_list[0].line_list[0].departure_state_list[0].class).to eq Ekispert::Course::Route::Line::DepartureState
            end
            describe 'Course::Route::Line::DepartureState instance' do
              describe '#type_list' do
                it 'return Array and contains Course::Route::Line::DepartureState::Type instance' do
                  expect(course.route_list[0].line_list[0].departure_state_list[0].type_list[0].class).to eq Ekispert::Course::Route::Line::DepartureState::Type
                end
              end
              describe '#datetime_list' do
                it 'return Array and contains Course::Route::Line::DepartureState::Datetime instance' do
                  expect(course.route_list[0].line_list[0].departure_state_list[0].datetime_list[0].class).to eq Ekispert::Course::Route::Line::DepartureState::Datetime
                end
              end
            end
          end
        end
      end
    end
  end
end
