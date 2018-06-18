require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::Point::Station do
  include Ekispert::SpecHelper::Config
  include UtilHelper

  describe '.convert_point_to_station' do
    let(:parsed_xml) { Ekispert::Client.send(:parse_xml, read_xml('point/tokyo_station.xml')) }
    let(:point_list) { Ekispert::Point.send(:to_point, parsed_xml) }
    let(:prefecture) { point_list[0].prefecture_list[0] }
    context 'use point/tokyo_station.xml' do
      describe 'Ekispert::Point::Prefecture' do
        describe '#name_list' do
          it 'return Array and contains Point::Prefecture::Name instance' do
            expect(prefecture.name_list[0].class).to eq Ekispert::Point::Prefecture::Name
          end
        end
      end
    end
  end
end
