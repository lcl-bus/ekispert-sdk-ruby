require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::OperationLine::Line do
  include UtilHelper

  let(:parsed_xml) { Ekispert::Client.send(:parse_xml, read_xml('operation_line/akita.xml')) }
  let(:operation_line) { Ekispert::OperationLine.send(:to_operation_line, parsed_xml) }
  let(:line) { operation_line.line_list[0] }

  describe '#name_list' do
    it 'contains Ekispert::OperationLine::Line::Name instance' do
      expect(line.name_list[0].class).to eq Ekispert::OperationLine::Line::Name
    end
  end
  describe '#yomi_list' do
    it 'contains Ekispert::OperationLine::Line::Yomi instance' do
      expect(line.yomi_list[0].class).to eq Ekispert::OperationLine::Line::Yomi
    end
  end
  describe '#color_list' do
    it 'contains Ekispert::OperationLine::Line::Color instance' do
      expect(line.color_list[0].class).to eq Ekispert::OperationLine::Line::Color
    end
  end
end
