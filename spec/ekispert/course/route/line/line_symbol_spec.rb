require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::Course::Route::Line::LineSymbol do
  include UtilHelper

  let(:xml) { read_xml('course/include_relation_search.xml') }
  let(:parsed_xml) { Ekispert::Client.send(:parse_xml, xml) }
  let(:course_list) { Ekispert::Course.send(:to_course, parsed_xml) }
  let(:line_symbol) { course_list[0].route_list[0].line_list[2].line_symbol_list[0] }

  describe '#name_list' do
    it 'return Array and contains Course::Route::Line::LineSymbol::Name instance' do
      expect(line_symbol.name_list[0].class).to eq Ekispert::Course::Route::Line::LineSymbol::Name
    end
  end
  describe '#name' do
    it 'should return correct value' do
      expect(line_symbol.name).to eq 'JC'
    end
  end
end
