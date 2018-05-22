require 'spec_helper'
require 'helper/ekispert/information_helper'

RSpec.describe Ekispert::Information do
  include Ekispert::SpecHelper::Config
  include Ekispert::SpecHelper::Information
  describe '.get' do
    before { set_ekispert_default_config }
    it 'Information class' do
      expect(Ekispert::Information.get(22_828, 'rail').class).to eq Ekispert::Information
    end
  end

  describe '.to_ekispert_class' do
    context 'There is only one argument' do
      let(:parsed_xml) { Ekispert::Client.send(:parse_xml, res_body_rail) }
      let(:information) { Ekispert::Information.send(:to_ekispert_class, parsed_xml, 'rail') }

      it 'Return Ekispert::Information class' do
        expect(information.class).to eq Ekispert::Information
      end
      it 'Ekispert::Information::Line instance in line_list' do
        expect(information.line_list[0].class).to eq Ekispert::Information::Line
      end
      it 'Ekispert::Information::Corporation instance in corporation_list' do
        expect(information.corporation_list[0].class).to eq Ekispert::Information::Corporation
      end
      it 'Other list is empty' do
        expect(information.exit_list).to be_empty
      end
    end

    context 'There are two argument' do
      let(:parsed_xml) { Ekispert::Client.send(:parse_xml, res_body_rail_and_exit) }
      let(:information) { Ekispert::Information.send(:to_ekispert_class, parsed_xml, 'rail:exit') }

      it 'Return Ekispert::Information class' do
        expect(information.class).to eq Ekispert::Information
      end
      it 'Ekispert::Information::Line instance in line_list' do
        expect(information.line_list[0].class).to eq Ekispert::Information::Line
      end
      it 'Ekispert::Information::Corporation instance in corporation_list' do
        expect(information.corporation_list[0].class).to eq Ekispert::Information::Corporation
      end
      it 'Ekispert::Information::Exit instance in exit_list' do
        expect(information.exit_list[0].class).to eq Ekispert::Information::Exit
      end
    end

    context 'There are same elements' do
      let(:parsed_xml) { Ekispert::Client.send(:parse_xml, res_body_same_elements) }
      let(:information) { Ekispert::Information.send(:to_ekispert_class, parsed_xml, 'rail:nearrail') }

      it 'Return Ekispert::Information class' do
        expect(information.class).to eq Ekispert::Information
      end
      it 'Ekispert::Information::Line RailInstance in line_list' do
        expect(information.line_list[0].class).to eq Ekispert::Information::Line
      end
      it 'Ekispert::Information::Line NearrailInstance in line_list' do
        expect(information.line_list[-1].class).to eq Ekispert::Information::Line
      end
      it 'Ekispert::Information::Corporation RailInstance in corporation_list' do
        expect(information.corporation_list[0].class).to eq Ekispert::Information::Corporation
      end
      it 'Ekispert::Information::Corporation NearrailInstance in corporation_list' do
        expect(information.corporation_list[-1].class).to eq Ekispert::Information::Corporation
      end
      it 'RailInstance in line_list' do
        expect(information.line_list[0].basetype).to eq 'Rail'
      end
      it 'NearrailInstance in line_list' do
        expect(information.line_list[-1].basetype).to eq 'Nearrail'
      end
      it 'RailInstance in corporation_list' do
        expect(information.corporation_list[0].basetype).to eq 'Rail'
      end
      it 'NearrailInstance in corporation_list' do
        expect(information.corporation_list[-1].basetype).to eq 'Nearrail'
      end
    end
  end
end
