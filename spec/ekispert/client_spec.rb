require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::Client do
  include Ekispert::SpecHelper::Config
  include UtilHelper
  before { set_ekispert_default_config }
  describe '.connection_options' do
    it 'return default options' do
      expect(Ekispert::Client.connection_options).to match(
        url: 'https://api.ekispert.jp/v1/xml',
        proxy: ENV['HTTP_PROXY'],
        headers: { 'Content-Type' => 'application/xml;charset=utf-8' },
        params: { key: ENV['EKISPERT_API_KEY'] },
        request: { timeout: 5, open_timeout: 2 }
      )
    end
  end
  describe '.set_connection' do
    context 'default options' do
      let(:connection) { Ekispert::Client.set_connection }
      it 'default url option' do
        expect(connection.url_prefix.to_s).to eq 'https://api.ekispert.jp/v1/xml'
      end
      it 'default proxy option' do
        expect(connection.proxy.class).to eq(Faraday::ProxyOptions) | eq(NilClass)
      end
      it 'default header option' do
        expect(connection.headers['Content-Type']).to eq 'application/xml;charset=utf-8'
      end
      it 'default params option' do
        expect(connection.params[:key]).to eq ENV['EKISPERT_API_KEY']
      end
      it 'default request option' do
        expect(connection.options.timeout).to eq 5
        expect(connection.options.open_timeout).to eq 2
      end
    end
  end
  describe '.get' do
    let(:res) { Ekispert::Client.get('dataversion') }
    context 'request has succeeded（request dataversion）' do
      it 'should return Nokogiri::XML::NodeSet instance' do
        expect(res.class).to eq Nokogiri::XML::NodeSet
      end
    end
    context 'api_key = nil' do
      before { set_ekispert_config(api_key: nil) }
      it 'should raise Ekispert::Error::Forbidden' do
        expect { res }.to raise_error(Ekispert::Error::Forbidden)
      end
    end
  end
  describe '.raise_error' do
    let(:stub) do
      Faraday.new do |conn|
        conn.adapter :test, Faraday::Adapter::Test::Stubs.new do |stub|
          stub.get('https://api.ekispert.jp') { [status_code, {}, read_xml('client_error.xml')] }
        end
      end
    end
    let(:error) { Ekispert::Client.send(:raise_error, stub.get('https://api.ekispert.jp')) }
    context 'status code 1' do
      let(:status_code) { 1 }
      it 'should raise Error::InternalError' do
        expect { error }.to raise_error(Ekispert::Error::InternalError)
      end
    end
    context 'status code 400' do
      let(:status_code) { 400 }
      it 'should raise Ekispert::Error::BadRequest' do
        expect { error }.to raise_error(Ekispert::Error::BadRequest)
      end
    end
    context 'status code 403' do
      let(:status_code) { 403 }
      it 'should raise Ekispert::Error::Forbidden' do
        expect { error }.to raise_error(Ekispert::Error::Forbidden)
      end
    end
    context 'status code 404' do
      let(:status_code) { 404 }
      it 'should raise Error::NotFound' do
        expect { error }.to raise_error(Ekispert::Error::NotFound)
      end
    end
    context 'status code 499' do
      let(:status_code) { 499 }
      it 'should raise Error::ClientError' do
        expect { error }.to raise_error(Ekispert::Error::ClientError)
      end
    end
    context 'status code 500' do
      let(:status_code) { 500 }
      it 'should raise Error::ServerError' do
        expect { error }.to raise_error(Ekispert::Error::ServerError)
      end
    end
    context 'status code 599' do
      let(:status_code) { 599 }
      it 'should raise Error::ServerError' do
        expect { error }.to raise_error(Ekispert::Error::ServerError)
      end
    end
  end
end
