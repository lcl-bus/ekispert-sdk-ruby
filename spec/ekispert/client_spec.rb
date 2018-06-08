require 'spec_helper'

RSpec.describe Ekispert::Client do
  include Ekispert::SpecHelper::Config
  before { set_ekispert_default_config }
  describe '.connection_options' do
    it 'return default options' do
      expect(Ekispert::Client.connection_options).to match(
        {
          url: 'https://api.ekispert.jp/v1/xml',
          proxy: ENV['HTTP_PROXY'],
          headers: { 'Content-Type' => 'application/xml;charset=utf-8' },
          params: { key: ENV['EKISPERT_API_KEY'] },
          request: { timeout: 5, open_timeout: 2 }
        }
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
  describe '.request' do
    context 'first char is "/"' do
      let(:res) { Ekispert::Client.send(:request, '/example', nil) }
      it 'request url is correct' do
        expect(res.env.url.to_s).to match 'https://api.ekispert.jp/v1/xml/example'
      end
    end
    context 'first char is not "/"' do
      let(:res) { Ekispert::Client.send(:request, 'example', nil) }
      it 'request url is correct' do
        expect(res.env.url.to_s).to match 'https://api.ekispert.jp/v1/xml/example'
      end
    end
  end
  describe '.get' do
    let(:xml) { Ekispert::Client.get('/dataversion') }
    context 'request has succeeded' do
      it 'not include "Error" element' do
        expect(xml.xpath('//Error')).to be_empty
      end
    end
    context 'request has failed' do
      before { set_ekispert_config(api_key: nil) }
      it 'include "Error" element' do
        expect { xml.xpath('//Error') }.to raise_error(Ekispert::Error::Forbidden)
      end
    end
  end
end
