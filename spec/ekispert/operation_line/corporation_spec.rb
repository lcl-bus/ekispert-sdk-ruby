require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::OperationLine::Corporation do
  include UtilHelper

  let(:parsed_xml) { Ekispert::Client.send(:parse_xml, read_xml('operation_line/akita.xml')) }
  let(:operation_line) { Ekispert::OperationLine.send(:to_operation_line, parsed_xml) }
  let(:corporation) { operation_line.corporation_list[0] }

  describe '#name_list' do
    it 'contains Ekispert::OperationLine::Corporation::Name instance' do
      expect(corporation.name_list[0].class).to eq Ekispert::OperationLine::Corporation::Name
    end
  end
  describe '#line_list' do
    context '秋田内陸縦貫鉄道' do
      let(:akita_corporation) { operation_line.corporation_list[1] }
      it 'should return correct value' do
        expect(akita_corporation.line_list[0].name_list[0].text).to eq '秋田内陸線'
      end
    end
  end
  describe '#name' do
    it 'should return correct value' do
      expect(corporation.name).to eq 'ＪＲ'
    end
  end
end
