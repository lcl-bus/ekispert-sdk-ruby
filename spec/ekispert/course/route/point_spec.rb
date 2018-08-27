require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::Course::Route::Point do
  include UtilHelper

  describe '.to_course（Point class part）' do
    let(:xml) { read_xml('course/landmark_and_geopoint_search.xml') }
    let(:parsed_xml) { Ekispert::Client.send(:parse_xml, xml) }
    let(:course_list) { Ekispert::Course.send(:to_course, parsed_xml) }
    let(:point_list) { course_list[0] }
    describe 'Course::Route::Point instance' do
      describe '#name_list' do
        it 'return Array and contains Course::Route::Point::Station instance' do
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
      describe '#point_list' do
        describe 'Course::Route::Point instance' do
          describe '#station_list' do
            it 'return Array and contains Course::Route::Point::Station instance' do
              expect(course.route_list[0].point_list[0].station_list[0].class).to eq Ekispert::Course::Route::Point::Station
            end
            describe 'Course::Route::Point::Station instance' do
              describe '#name_list' do
                it 'return Array and contains Course::Route::Point::Station::Name instance' do
                  expect(course.route_list[0].point_list[0].station_list[0].name_list[0].class).to eq Ekispert::Course::Route::Point::Station::Name
                end
              end
              describe '#type_list' do
                it 'return Array and contains Course::Route::Point::Station::Type instance' do
                  expect(course.route_list[0].point_list[0].station_list[0].type_list[0].class).to eq Ekispert::Course::Route::Point::Station::Type
                end
              end
              describe '#yomi_list' do
                it 'return Array and contains Course::Route::Point::Station::Yomi instance' do
                  expect(course.route_list[0].point_list[0].station_list[0].yomi_list[0].class).to eq Ekispert::Course::Route::Point::Station::Yomi
                end
              end
            end
          end
          describe '#prefecture_list' do
            it 'return Array and contains Course::Route::Point::Prefecture instance' do
              expect(course.route_list[0].point_list[0].prefecture_list[0].class).to eq Ekispert::Course::Route::Point::Prefecture
            end
            describe 'Course::Route::Point::Prefecture instance' do
              describe '#name_list' do
                it 'return Array and contains Course::Route::Point::Prefecture::Name instance' do
                  expect(course.route_list[0].point_list[0].prefecture_list[0].name_list[0].class).to eq Ekispert::Course::Route::Point::Prefecture::Name
                end
              end
            end
          end
          describe '#geopoint_list' do
            it 'return Array and contains Course::Route::Point::GeoPoint instance' do
              expect(course.route_list[0].point_list[0].geo_point_list[0].class).to eq Ekispert::Course::Route::Point::GeoPoint
            end
          end
        end
      end
    end
  end
end
