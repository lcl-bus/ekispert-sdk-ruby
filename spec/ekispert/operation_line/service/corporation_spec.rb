require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::OperationLine::Service::Corporation do
  include UtilHelper

  let(:parsed_xml) { Ekispert::Client.send(:parse_xml, read_xml('operation_line/service/information.xml')) }
  let(:service) { Ekispert::OperationLine::Service.send(:to_service, parsed_xml) }
  let(:corporation) { service.corporation_list[0] }

  describe '#name_list' do
    it 'contains Ekispert::OperationLine::Service::Corporation::Name instance' do
      expect(corporation.name_list[0].class).to eq Ekispert::OperationLine::Service::Corporation::Name
    end
  end
end
