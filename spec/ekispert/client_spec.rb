require 'spec_helper'

RSpec.describe Ekispert::Client do
  describe '.connection_options' do
    it 'return default options' do
      expect(Ekispert::Client.connection_options).to match(
        {
          url: 'https://api.ekispert.jp/v1/xml',
          proxy: ENV['http_proxy'],
          headers: { 'Content-Type' => 'application/xml;charset=utf-8' },
          params: { key: '' },
          request: { timeout: 5, open_timeout: 2 }
        }
      )
    end
  end
  describe '.set_connection' do
    let(:connection) { Ekispert::Client.set_connection }
    context 'use default option' do
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
        expect(connection.params[:key]).to eq ''
      end
      it 'default request option' do
        expect(connection.options.timeout).to eq 5
        expect(connection.options.open_timeout).to eq 2
      end
    end
  end
end
