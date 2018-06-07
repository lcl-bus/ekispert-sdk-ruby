require 'spec_helper'
require 'helper/ekispert/information_helper'

RSpec.describe Ekispert::Information do
  include Ekispert::SpecHelper::Config
  include Ekispert::SpecHelper::Information
  describe '.get' do
    before { set_ekispert_default_config }
    context 'Use type = rail' do
      let(:information) { Ekispert::Information.get(code: 22828, type: 'rail') }
      it 'Return array class' do
        expect(information.class).to eq Array
      end
      it 'Array include Ekispert::Information instance' do
        expect(information[0].class).to eq Ekispert::Information
      end
    end
  end

  describe '.to_information_class' do
    context 'There is only one argument' do
      let(:parsed_xml) { Ekispert::Client.send(:parse_xml, res_body_rail) }
      let(:information) { Ekispert::Information.send(:to_information_class, parsed_xml) }

      it 'line_list in Ekispert::Information::Line instance' do
        expect(information[0].line_list[0].class).to eq Ekispert::Information::Line
      end
      it 'Name element is included Ekispert::Information::Line instance' do
        expect(information[0].line_list[0].name_list[0].text).to eq "ＪＲ新幹線のぞみ"
      end
      it 'Type element is included Ekispert::Information::Line instance ' do
        expect(information[0].line_list[0].type_list[0].text).to eq 'train'
      end
      it 'Color element is included Ekispert::Information::Line instance ' do
        expect(information[0].line_list[0].color_list[0].text).to eq '051102255'
      end
      it 'corporation_list in Ekispert::Information::Corporation instance' do
        expect(information[0].corporation_list[0].class).to eq Ekispert::Information::Corporation
      end
      it 'Corporation element is included Ekispert::Information::Corporation instance' do
        expect(information[0].corporation_list[0].name_list[0].text).to eq "ＪＲ"
      end
      it 'type_list in Ekispert::Information::Type instance' do
        expect(information[0].type_list[0].class).to eq Ekispert::Information::Type
      end
      it 'Type element is included in Ekispert::Information::Type instance' do
        expect(information[0].type_list[0].text).to eq 'rail'
      end
      it 'Other list is empty' do
        expect(information[0].exit_list).to be_empty
      end
    end

    context 'There are two argument' do
      let(:parsed_xml) { Ekispert::Client.send(:parse_xml, res_body_rail_and_exit) }
      let(:information) { Ekispert::Information.send(:to_information_class, parsed_xml) }

      it 'Ekispert::Information::Line instance in line_list' do
        expect(information[0].line_list[0].class).to eq Ekispert::Information::Line
      end
      it 'Name element is included Ekispert::Information::Line instance ' do
        expect(information[0].line_list[0].name_list[0].text).to eq "ＪＲ新幹線ひかり(東京－博多)"
      end
      it 'Type element is included Ekispert::Information::Line instance ' do
        expect(information[0].line_list[0].type_list[0].text).to eq 'train'
      end
      it 'Color element is included Ekispert::Information::Line instance ' do
        expect(information[0].line_list[0].color_list[0].text).to eq '001044255'
      end
      it 'Ekispert::Information::Corporation instance in corporation_list' do
        expect(information[0].corporation_list[0].class).to eq Ekispert::Information::Corporation
      end
      it 'Corporation element is included Ekispert::Information::Corporation instance' do
        expect(information[0].corporation_list[0].name_list[0].text).to eq "ＪＲ"
      end
      it 'type_list in Ekispert::Information::Type instance' do
        expect(information[0].type_list[0].class).to eq Ekispert::Information::Type
      end
      it 'Type element is included Ekispert::Information::Type instance' do
        expect(information[0].type_list[0].text).to eq 'rail'
      end
      it 'Ekispert::Information::Line instance not in Ekispert::Information::Exit instance' do
        expect(information[0].exit_list).to be_empty
      end
      it 'Ekispert::Information::Exit instance in exit_list' do
        expect(information[-1].exit_list[0].class).to eq Ekispert::Information::Exit
      end
      it 'Name element is included Ekispert::Information::Exit instance' do
        expect(information[-1].exit_list[0].name_list[0].text).to eq "１出口"
      end
      it 'Ekispert::Information::Exit instance not in Ekispert::Information::Line instance' do
        expect(information[-1].line_list).to be_empty
      end
    end

    context 'There are same elements' do
      let(:parsed_xml) { Ekispert::Client.send(:parse_xml, res_body_same_elements) }
      let(:information) { Ekispert::Information.send(:to_information_class, parsed_xml) }

      it 'Ekispert::Information::Line RailInstance in line_list' do
        expect(information[0].line_list[0].class).to eq Ekispert::Information::Line
      end
      it 'Name element of RailInstance is included Ekispert::Information::Line RailInstance' do
        expect(information[0].line_list[0].name_list[0].text).to eq "ＪＲ新幹線やまびこ"
      end
      it 'Type element of RailInstance is included Ekispert::Information::Line RailInstance ' do
        expect(information[0].line_list[0].type_list[0].text).to eq 'train'
      end
      it 'Color element of is included Ekispert::Information::Line RailInstance ' do
        expect(information[0].line_list[0].color_list[0].text).to eq '000208030'
      end
      it 'Ekispert::Information::Corporation RailInstance in corporation_list' do
        expect(information[0].corporation_list[0].class).to eq Ekispert::Information::Corporation
      end
      it 'Corporation element of RailInstance is included Ekispert::Information::Corporation RailInstance' do
        expect(information[0].corporation_list[0].name_list[0].text).to eq "ＪＲ"
      end
      it 'type_list in Ekispert::Information::Type RailInstance' do
        expect(information[0].type_list[0].class).to eq Ekispert::Information::Type
      end
      it 'Type element of RailInstance is included Ekispert::Information::Type RailInstance' do
        expect(information[0].type_list[0].text).to eq 'rail'
      end
      it 'Ekispert::Information::Line RailInstance in line_list' do
        expect(information[-1].line_list[0].class).to eq Ekispert::Information::Line
      end
      it 'Name element of NearraailInstance is included Ekispert::Information::Line NearraailInstance' do
        expect(information[-1].line_list[0].name_list[0].text).to eq "ＪＲ新幹線たにがわ"
      end
      it 'Type element of NearraailInstance is included Ekispert::Information::Line NearraailInstance ' do
        expect(information[-1].line_list[0].type_list[0].text).to eq 'train'
      end
      it 'Color element of NearraailInstance is included Ekispert::Information::Line NearraailInstance ' do
        expect(information[-1].line_list[0].color_list[0].text).to eq '000208030'
      end
      it 'Ekispert::Information::Corporation NearraailInstance in corporation_list' do
        expect(information[-1].corporation_list[0].class).to eq Ekispert::Information::Corporation
      end
      it 'Corporation element of NearraailInstance is included Ekispert::Information::Corporation NearraailInstance' do
        expect(information[-1].corporation_list[0].name_list[0].text).to eq "ＪＲ"
      end
      it 'type_list in Ekispert::Information::Type NearraailInstance' do
        expect(information[-1].type_list[0].class).to eq Ekispert::Information::Type
      end
      it 'Type element of NearraailInstance is included Ekispert::Information::Type NearraailInstance' do
        expect(information[-1].type_list[0].text).to eq 'nearrail'
      end
    end
  end
end
