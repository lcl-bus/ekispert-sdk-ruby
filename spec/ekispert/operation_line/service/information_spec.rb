require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::OperationLine::Service::Information do
  include UtilHelper

  let(:parsed_xml) { Ekispert::Client.send(:parse_xml, read_xml('operation_line/service/information.xml')) }
  let(:service) { Ekispert::OperationLine::Service.send(:to_service, parsed_xml) }
  let(:information) { service.information_list[0] }

  describe '#comment_list' do
    it 'contains Ekispert::OperationLine::Service::Information::Comment instance' do
      expect(information.comment_list[0].class).to eq Ekispert::OperationLine::Service::Information::Comment
    end
  end
  describe '#datetime_list' do
    it 'contains Ekispert::OperationLine::Service::Information::Datetime instance' do
      expect(information.datetime_list[0].class).to eq Ekispert::OperationLine::Service::Information::Datetime
    end
  end
  describe '#line_list' do
    it 'contains Ekispert::OperationLine::Service::Information::Line instance' do
      expect(information.line_list[0].class).to eq Ekispert::OperationLine::Service::Information::Line
    end
  end
  describe '#title_list' do
    it 'contains Ekispert::OperationLine::Service::Information::Title instance' do
      expect(information.title_list[0].class).to eq Ekispert::OperationLine::Service::Information::Title
    end
  end
end
