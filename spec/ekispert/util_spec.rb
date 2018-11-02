require 'spec_helper'

RSpec.describe Ekispert::Util do
  include Ekispert::Util
  describe '.snakecase' do
    context 'str = "Station"' do
      it 'return "station"' do
        expect(snakecase('Station')).to eq 'station'
      end
    end
    context 'str = "DataVersion"' do
      it 'return "data_version"' do
        expect(snakecase('DataVersion')).to eq 'data_version'
      end
    end
    context 'str = "data_version"' do
      it 'return "data_version"' do
        expect(snakecase('data_version')).to eq 'data_version'
      end
    end
    context 'str = "JRReservation"' do
      it 'return "jr_reservation"' do
        expect(snakecase('JRReservation')).to eq 'jr_reservation'
      end
    end
    context 'str = "exhaustCO2atPassengerCar"' do
      it 'return "exhaust_co2_at_passenger_car"' do
        expect(snakecase('exhaustCO2atPassengerCar')).to eq 'exhaust_co2_at_passenger_car'
      end
    end
    context 'str = "IC"' do
      it 'return "ic"' do
        expect(snakecase('IC')).to eq 'ic'
      end
    end
  end
end
