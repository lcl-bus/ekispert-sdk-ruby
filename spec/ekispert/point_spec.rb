require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::Point do
  include Ekispert::SpecHelper::Config
  include UtilHelper

  describe '.get_station' do
    before { set_ekispert_default_config }
    context 'use station code（東京）' do
      context 'params key type is String' do
        let(:point_list) { Ekispert::Point.get_station('code' => '22828') }
        it 'point_list array include Ekispert::Point instance' do
          expect(point_list[0].class).to eq Ekispert::Point
        end
      end
      context 'params key type is Symbol' do
        let(:point_list) { Ekispert::Point.get_station(code: '22828') }
        it 'return Array class' do
          expect(point_list.class).to eq Array
        end
        it 'point_list array contains one element' do
          expect(point_list.size).to eq 1
        end
        it 'point_list array include Ekispert::Point instance' do
          expect(point_list[0].class).to eq Ekispert::Point
        end
      end
    end
    context 'use name "東京"' do
      let(:point_list) { Ekispert::Point.get_station(name: '東京') }
      it 'station_list array contains multiple element' do
        expect(point_list.size).to be > 1
      end
      it 'include "東京" station（code "22828"） element' do
        expect(point_list.find { |point| point.station_list[0].code == '22828' }).not_to be nil
      end
      it 'include busstop element' do
        expect(point_list.find { |point| point.station_list[0].type_list[0].text == 'bus' }).not_to be nil
      end
      context 'use busstop param' do
        let(:point_list) { Ekispert::Point.get_station(name: '東京', type: 'bus') }
        it 'include only busstop element' do
          expect(point_list.all? { |point| point.station_list[0].type_list[0].text == 'bus' }).to be true
        end
      end
    end
    context 'params include invalid code' do
      let(:point_list) { Ekispert::Point.get_station(code: '00000') }
      it 'station_list array not contains element' do
        expect { point_list }.to raise_error(Ekispert::Error::BadRequest)
      end
    end
    context 'params include invalid name' do
      let(:point_list) { Ekispert::Point.get_station(name: 'ん') }
      it 'station_list array not contains element' do
        expect(point_list).to be_empty
      end
    end
  end
  describe '.get_station_light' do
    before { set_ekispert_default_config }
    context 'use station code（東京）' do
      let(:point_list) { Ekispert::Point.get_station_light(code: '22828') }
      describe 'Ekispert::Point#geo_point_list' do
        it 'should return empty' do
          expect(point_list[0].geo_point_list).to be_empty
        end
      end
    end
  end
  describe '.to_point' do
    let(:parsed_xml) { Ekispert::Client.send(:parse_xml, read_xml('point/use_geopoint_and_gate_group.xml')) }
    let(:point_list) { Ekispert::Point.send(:to_point, parsed_xml) }
    context 'use point/use_geopoint_and_gate_group.xml' do
      describe 'Ekispert::Point' do
        describe '#prefecture_list' do
          it 'contains Point::Prefecture instance' do
            expect(point_list[0].prefecture_list[0].class).to eq Ekispert::Point::Prefecture
          end
        end
        describe '#geo_point_list' do
          it 'contains Point::GeoPoint instance' do
            expect(point_list[0].geo_point_list[0].class).to eq Ekispert::Point::GeoPoint
          end
        end
      end
    end
  end
  context 'use point/use_old_station_name.xml' do
    let(:parsed_xml) { Ekispert::Client.send(:parse_xml, read_xml('point/use_old_station_name.xml')) }
    describe '#station' do
      let(:point_list) { Ekispert::Point.send(:to_point, parsed_xml) }
      it 'should return Point::Station instance' do
        expect(point_list[0].station.instance_of?(Ekispert::Point::Station)).to be true
      end
    end
    describe '#prefecture' do
      let(:point_list) { Ekispert::Point.send(:to_point, parsed_xml) }
      it 'should return Point::Prefecture instance' do
        expect(point_list[0].prefecture.instance_of?(Ekispert::Point::Prefecture)).to be true
      end
    end
    describe '#geo_point' do
      let(:point_list) { Ekispert::Point.send(:to_point, parsed_xml) }
      it 'should return Point::GeoPoint instance' do
        expect(point_list[0].geo_point.instance_of?(Ekispert::Point::GeoPoint)).to be true
      end
    end
  end
end
