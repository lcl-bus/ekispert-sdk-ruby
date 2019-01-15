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
end
