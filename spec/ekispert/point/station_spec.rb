require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::Point::Station do
  include Ekispert::SpecHelper::Config
  include UtilHelper

  describe '.get' do
    before { set_ekispert_default_config }
    context 'use station code（東京）' do
      let(:station_list) { Ekispert::Point::Station.get(code: '22828') }
      it 'station_list array include Ekispert::Point::Station instance' do
        expect(station_list[0].class).to eq Ekispert::Point::Station
      end
    end
  end
  describe '.convert_point_to_station' do
    let(:xml) { read_xml('point/use_geopoint_and_gate_group.xml') }
    let(:parsed_xml) { Ekispert::Client.send(:parse_xml, xml) }
    let(:point_list) { Ekispert::Point.send(:to_point, parsed_xml) }
    let(:station_list) { Ekispert::Point::Station.send(:convert_point_to_station, point_list) }
    context 'use point/use_geopoint_and_gate_group.xml' do
      describe 'Point::Station instance' do
        let(:station) { station_list[0] }
        describe '#prefecture_list' do
          it 'contains Point::Prefecture instance' do
            expect(station.prefecture_list[0].class).to eq Ekispert::Point::Prefecture
          end
        end
        describe '#geo_point_list' do
          it 'contains Point::Station::GeoPoint instance' do
            expect(station.geo_point_list[0].class).to eq Ekispert::Point::Station::GeoPoint
          end
        end
        describe '#gate_group_list' do
          it 'contains Point::Station::GateGroup instance' do
            expect(station.gate_group_list[0].gate_list[0].class).to eq Ekispert::Point::Station::GateGroup::Gate
          end
          describe 'Point::Station::GateGroup' do
            it 'contains Point::Station::GateGroup::Gate::Name instance' do
              expect(station.gate_group_list[0].gate_list[0].name_list[0].class).to eq Ekispert::Point::Station::GateGroup::Gate::Name
            end
            it 'contains Point::Station::GateGroup::Gate::GeoPoint instance' do
              expect(station.gate_group_list[0].gate_list[0].geo_point_list[0].class).to eq Ekispert::Point::Station::GateGroup::Gate::GeoPoint
            end
          end
        end
      end
      # TODO: params include railName param
    end
    context 'use point/use_old_station_name.xml' do
      # params = { oldName: "業平橋" }
      let(:xml) { read_xml('point/use_old_station_name.xml') }
      describe 'Station::OldName#text' do
        it 'should return "業平橋"' do
          expect(station_list[0].old_name_list[0].text).to eq '業平橋'
        end
      end
    end
  end
end
