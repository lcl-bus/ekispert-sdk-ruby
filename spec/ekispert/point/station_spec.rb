require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::Point::Station do
  include Ekispert::SpecHelper::Config
  include UtilHelper

  describe '.get' do
    before { set_ekispert_default_config }
    context 'use station code（東京）' do
      let(:station_list) { Ekispert::Point::Station.get(code: '22828') }
      it 'should return Array class' do
        expect(station_list.class).to eq Array
      end
      it 'station_list array contains one element' do
        expect(station_list.size).to eq 1
      end
      it 'station_list array include Ekispert::Point::Station instance' do
        expect(station_list[0].class).to eq Ekispert::Point::Station
      end
    end
    context 'use name "東京"' do
      let(:station_list) { Ekispert::Point::Station.get(name: '東京') }
      it 'station_list array contains multiple element' do
        expect(station_list.size).to be > 1
      end
      it 'include "東京" station（code "22828"） element' do
        expect(station_list.find { |station| station.code == '22828' }).not_to be nil
      end
      it 'include busstop element' do
        expect(station_list.find { |station| station.type_list[0].text == 'bus' }).not_to be nil
      end
      context 'use busstop param' do
        let(:station_list) { Ekispert::Point::Station.get(name: '東京', type: 'bus') }
        it 'include only busstop element' do
          expect(station_list.all? { |station| station.type_list[0].text == 'bus' }).to be true
        end
      end
    end
    context 'params include invalid code' do
      let(:station_list) { Ekispert::Point::Station.get(code: '00000') }
      it 'station_list array not contains element' do
        expect(station_list).to be_empty
      end
    end
    context 'params include invalid name' do
      let(:station_list) { Ekispert::Point::Station.get(name: 'ん') }
      it 'station_list array not contains element' do
        expect(station_list).to be_empty
      end
    end
  end
  describe '.convert_point_to_station' do
    let(:parsed_xml) { Ekispert::Client.send(:parse_xml, xml) }
    let(:point_list) { Ekispert::Point.send(:to_point, parsed_xml) }
    let(:station_list) { Ekispert::Point::Station.send(:convert_point_to_station, point_list) }
    context 'get Tokyo station' do
      let(:xml) { read_xml('point/tokyo_station.xml') }
      context 'params = { code: "22828" }' do
        context 'call Station#code' do
          it 'should return "22828"' do
            expect(station_list[0].code).to eq '22828'
          end
        end
        context 'call Station::Name#text' do
          it 'should return "東京"' do
            expect(station_list[0].name_list[0].text).to eq '東京'
          end
        end
        context 'call Station::Name#to_s' do
          it 'should return "東京"' do
            expect(station_list[0].name_list[0].to_s).to eq '東京'
          end
        end
        context 'call Station::Yomi#text' do
          it 'should return "とうきょう"' do
            expect(station_list[0].yomi_list[0].text).to eq 'とうきょう'
          end
        end
        context 'Station::Yomi#to_s' do
          it 'should return "とうきょう"' do
            expect(station_list[0].yomi_list[0].to_s).to eq 'とうきょう'
          end
        end
        it 'Station instance can be called #prefecture_list' do
          expect(station_list[0].prefecture_list.size).to eq 1
        end
        it 'Station instance can be called Point::Prefecture#code' do
          expect(station_list[0].prefecture_list[0].code).to eq '13'
        end
        it 'Station instance can be called Point::Prefecture::Name#text' do
          expect(station_list[0].prefecture_list[0].name_list[0].text).to eq '東京都'
        end
        it 'Station instance can be called Point::Prefecture::Name#to_s' do
          expect(station_list[0].prefecture_list[0].name_list[0].to_s).to eq '東京都'
        end
      end
      context "params = { code: '22671', gcs: 'tokyo', addGateGroup: 'true' }" do
        let(:xml) { read_xml('point/use_geopoint_and_gate_group.xml') }
        it 'Station instance can be called #geo_point_list' do
          expect(station_list[0].geo_point_list.size).to eq 1
        end
        it 'Station instance can be called Point::Point::GeoPoint#longi' do
          expect(station_list[0].geo_point_list[0].longi).to eq '139.39.10.89'
        end
        it 'Station instance can be called Point::GeoPoint#lati' do
          expect(station_list[0].geo_point_list[0].lati).to eq '35.42.7.59'
        end
        it 'Station instance can be called Point::GeoPoint#longi_d' do
          expect(station_list[0].geo_point_list[0].longi_d).to eq '139.653027'
        end
        it 'Station instance can be called Point::GeoPoint#lati_d' do
          expect(station_list[0].geo_point_list[0].lati_d).to eq '35.70211'
        end
        it 'Station instance can be called Point::GeoPoint#gcs' do
          expect(station_list[0].geo_point_list[0].gcs).to eq 'tokyo'
        end
        it 'Station instance can be called #gate_group_list' do
          expect(station_list[0].gate_group_list.size).to eq 1
        end
        it 'Station instance can be called Point::GateGroup::Gate#code' do
          expect(station_list[0].gate_group_list[0].gate_list[0].code).to eq 'G3929'
        end
        it 'Station instance can be called Point::GateGroup::Gate::Name#text' do
          expect(station_list[0].gate_group_list[0].gate_list[0].name_list[0].text).to eq '南口'
        end
        it 'Station instance can be called Point::GateGroup::Gate::GeoPoint#gcs' do
          expect(station_list[0].gate_group_list[0].gate_list[0].geo_point_list[0].gcs).to eq 'tokyo'
        end
      end
      # TODO: params include railName param
    end
    context 'use oldName param' do
      let(:xml) { read_xml('point/use_old_station_name.xml') }
      context 'params = { oldName: "業平橋" }' do
        context 'call Station::Name#text' do
          it 'should return "とうきょうスカイツリー"' do
            expect(station_list[0].name_list[0].text).to eq 'とうきょうスカイツリー'
          end
        end
        context 'call Station::OldName#text' do
          it 'should return "業平橋"' do
            expect(station_list[0].old_name_list[0].text).to eq '業平橋'
          end
        end
      end
    end
  end
end
