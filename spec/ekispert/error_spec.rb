require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::Error do
  include UtilHelper
  describe 'ClientError' do
    let(:stb) do
      Faraday.new do |conn|
        conn.adapter :test, Faraday::Adapter::Test::Stubs.new do |stub|
          stub.get('https://api.ekispert.jp') { [499, {}, read_xml('client_error.xml')] }
        end
      end
    end
    let(:res) { stb.get('https://api.ekispert.jp') }
    let(:error) { Ekispert::Error::ClientError.new(res) }
    describe '#initialize' do
      it 'should return status code' do
        expect(error.message).to match(/status\s+:\s+499/)
      end
      it 'should return url' do
        expect(error.message).to match(/URL\s+:\s+https:\/\/api.ekispert.jp/)
      end
      it 'should return message' do
        expect(error.message).to match(/message\s+:\s+First.*\nSecond/)
      end
    end
    describe '.split_message' do
      let(:messages) { error.send(:split_message, res.body) }
      it 'should return Array' do
        expect(messages.class).to eq Array
      end
      it 'should contains two elements' do
        expect(messages.size).to eq 2
      end
    end
  end
end
