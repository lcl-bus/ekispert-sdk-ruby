require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::OperationLine::Service do
  include Ekispert::SpecHelper::Config
  include UtilHelper

  describe '.find' do
    before { set_ekispert_default_config }
    let(:service) { Ekispert::OperationLine::Service.find }
    it 'return Ekispert::OperationLine::Service instance' do
      expect(service.class).to eq Ekispert::OperationLine::Service
    end
  end
  describe '.to_service' do
    let(:parsed_xml) { Ekispert::Client.send(:parse_xml, read_xml('operation_line/service/information.xml')) }
    let(:sample_service) { Ekispert::OperationLine::Service.send(:to_service, parsed_xml) }
    describe '#corporation_list' do
      it 'contains Ekispert::OperationLine::Service::Corporation instance' do
        expect(sample_service.corporation_list[0].class).to eq Ekispert::OperationLine::Service::Corporation
      end
    end
    describe '#information_list' do
      it 'contains Ekispert::OperationLine::Service::Information instance' do
        expect(sample_service.information_list[0].class).to eq Ekispert::OperationLine::Service::Information
      end
    end
  end
end
