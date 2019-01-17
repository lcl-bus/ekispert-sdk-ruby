require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::OperationLine do
  include Ekispert::SpecHelper::Config
  include UtilHelper

  describe '.find' do
    before { set_ekispert_default_config }
    let(:operation_line) { Ekispert::OperationLine.find }
    it 'return Ekispert::OperationLine instance' do
      expect(operation_line.class).to eq Ekispert::OperationLine
    end
  end
  describe '.to_operation_line' do
    let(:parsed_xml) { Ekispert::Client.send(:parse_xml, xml) }
    context 'results not found' do
      let(:xml) { read_xml('empty_elem.xml') }
      let(:no_operation_line) { Ekispert::OperationLine.send(:to_operation_line, parsed_xml) }
      it 'should return nil' do
        expect(no_operation_line).to be nil
      end
    end
    context 'params = { prefectureCode: 5 }' do
      let(:xml) { read_xml('operation_line/akita.xml') }
      let(:akita_operation_line) { Ekispert::OperationLine.send(:to_operation_line, parsed_xml) }
      describe '#line_list' do
        it 'return Array and contains ten elements' do
          expect(akita_operation_line.line_list.size).to eq 10
        end
      end
      describe '#corporation_list' do
        it 'return Array and contains three elements' do
          expect(akita_operation_line.corporation_list.size).to eq 3
        end
      end
    end
  end
end
