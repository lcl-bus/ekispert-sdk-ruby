require 'spec_helper'

RSpec.describe Ekispert::Point do
  include Ekispert::SpecHelper::Config

  describe '.get_station' do
    before { set_ekispert_default_config }
    context 'use station code（東京）' do
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
      it 'geo_point_list array not contains instance' do
        expect(point_list[0].geo_point_list[0].class).to eq NilClass
      end
    end
  end

end
