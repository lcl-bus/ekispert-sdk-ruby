require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::Point::Station::GateGroup::Gate do
  include Ekispert::SpecHelper::Config
  include UtilHelper

  let(:parsed_xml) { Ekispert::Client.send(:parse_xml, xml) }
  let(:point_list) { Ekispert::Point.send(:to_point, parsed_xml) }
  let(:station_list) { Ekispert::Point::Station.send(:convert_point_to_station, point_list) }
  let(:gate) { station_list[0].gate_group.gate_list[0] }

  context 'use point/tokyo_station.xml' do
    let(:xml) { read_xml('point/use_geopoint_and_gate_group.xml') }

    describe '#name' do
      it 'should return "南口"' do
        expect(gate.name).to eq '南口'
      end
    end
    describe '#geo_point' do
      it 'should return Point::Station::GateGroup::Gate::GeoPoint instance' do
        expect(gate.geo_point.instance_of?(Ekispert::Point::Station::GateGroup::Gate::GeoPoint)).to be true
      end
    end
  end
end
