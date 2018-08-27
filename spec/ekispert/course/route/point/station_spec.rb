require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::Course::Route::Point::Station do
  include UtilHelper

  describe '.to_course（Station class part）' do
    let(:xml) { read_xml('course/simple_search.xml') }
    let(:parsed_xml) { Ekispert::Client.send(:parse_xml, xml) }
    let(:course_list) { Ekispert::Course.send(:to_course, parsed_xml) }
    let(:course) { course_list[0] }
    let(:point_list) { course_list[0].point_list }



    describe '#code' do
      it 'should return value of Ekispert::Course::Route::Point::Station#code' do
        expect(point_list[0].station.code).eq ('22828')
      end
    end

    describe '#name' do
      it 'should return value of Ekispert::Course::Route::Point::Station::Name#text' do
        expect(point_list[0].station.name).eq ('東京')
      end
    end

    describe '#geo_point' do
      ...
    end

    describe '#prefecture' do
      ...
    end

  end
end
