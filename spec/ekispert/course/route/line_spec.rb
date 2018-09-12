require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::Course::Route::Line do
  include UtilHelper

  let(:xml) { read_xml('course/shinkansen_search.xml') }
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
  describe '#corporation_list' do
    let(:xml) { read_xml('course/shinkansen_search.xml') }
    it 'return Array and contains Course::Route::Line::Corporation instance' do
      expect(line.corporation_list[0].class).to eq Ekispert::Course::Route::Line::Corporation
    end
  end
  describe '#typical_name_list' do
    let(:xml) { read_xml('course/include_relation_search.xml') }
    it 'return Array and contains Course::Route::Line::TypicalName instance' do
      expect(line.typical_name_list[0].class).to eq Ekispert::Course::Route::Line::TypicalName
    end
  end
  describe '#arrival_state' do
    it 'can call #no, return correct value' do
      expect(line.arrival_state.no).to eq '21'
    end
  end
  describe '#departure_state' do
    it 'can call #no, return correct value' do
      expect(line.departure_state.no).to eq '18'
    end
  end
  describe '#corporation' do
    it 'should return Course::Route::Line::Corporation instance' do
      expect(line.corporation.class).to eq Ekispert::Course::Route::Line::Corporation
    end
  end
  describe '#color' do
    it 'should return correct value' do
      expect(line.color).to eq '001032197'
    end
  end
  describe '#destination' do
    it 'should return correct value' do
      expect(line.destination).to eq '広島'
    end
  end
  describe '#name' do
    it 'should return correct value' do
      expect(line.name).to eq 'ＪＲ新幹線のぞみ'
    end
  end
  describe '#number' do
    it 'should return correct value' do
      expect(line.number).to eq '130'
    end
  end
  describe '#time_reliability' do
    it 'should return correct value' do
      expect(line.time_reliability).to eq 'onTimetable'
    end
  end
  describe '#type' do
    it 'should return correct value' do
      expect(line.type).to eq 'train'
    end
  end
  describe '#typical_name' do
    let(:xml) { read_xml('course/include_relation_search.xml') }
    it 'should return correct value' do
      expect(line.typical_name).to eq '関東バス・荻５１'
    end
  end
end
