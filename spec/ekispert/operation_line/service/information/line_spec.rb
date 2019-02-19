require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::OperationLine::Service::Information::Line do
  include UtilHelper

  let(:parsed_xml) { Ekispert::Client.send(:parse_xml, read_xml('operation_line/service/information.xml')) }
  let(:service) { Ekispert::OperationLine::Service.send(:to_service, parsed_xml) }
  let(:line) { service.information_list[0].line_list[0] }

  describe '#name_list' do
    it 'contains Ekispert::OperationLine::Service::Information::Line::Name instance' do
      expect(line.name_list[0].class).to eq Ekispert::OperationLine::Service::Information::Line::Name
    end
  end
  describe '#name' do
    it 'should return correct value' do
      expect(line.name).to eq '山万ユーカリが丘線(ユーカリが丘－女子大)'
    end
  end
  describe '#corporation' do
    it 'should return correct value' do
      expect(line.corporation.name_list[0].text).to eq '山万'
    end
  end
end
