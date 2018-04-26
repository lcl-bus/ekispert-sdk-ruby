require 'spec_helper'

RSpec.describe Ekispert::Client do
  describe '.connection_options' do
    before do
      Ekispert::Config.set do |c|
        c.host = 'https://api.ekispert.jp'
        c.version = 'v1'
        c.http_proxy = ENV['http_proxy']
        c.api_key = ''
      end
    end
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
    context 'default options' do
      let(:connection) do
        Ekispert::Config.set do |c|
          c.host = 'https://api.ekispert.jp'
          c.version = 'v1'
          c.http_proxy = ENV['http_proxy']
          c.api_key = ''
        end
        Ekispert::Client.set_connection
      end
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
  describe '.request' do
    before do
      Ekispert::Config.set do |c|
        c.host = 'https://api.ekispert.jp'
        c.version = 'v1'
        c.http_proxy = ENV['http_proxy']
        c.api_key = ENV['EKISPERT_API_KEY']
      end
    end
    context 'first char is "/"' do
      it 'request url is correct' do
        res = Ekispert::Client.send(:request, '/example', nil)
        expect(res.env.url.to_s).to match 'https://api.ekispert.jp/v1/xml/example'
      end
    end
    context 'first char is not "/"' do
      it 'request url is correct' do
        res = Ekispert::Client.send(:request, 'example', nil)
        expect(res.env.url.to_s).to match 'https://api.ekispert.jp/v1/xml/example'
      end
    end
  end
  describe '.get' do
    before do
      Ekispert::Config.set do |c|
        c.host = 'https://api.ekispert.jp'
        c.version = 'v1'
        c.http_proxy = ENV['http_proxy']
        c.api_key = ENV['EKISPERT_API_KEY']
      end
    end
    context 'request has succeeded' do
      it 'parse xml' do
        res = Ekispert::Client.get('/dataversion')
        expect(res[0].name).to eq 'ResultSet'
      end
    end
  end
end
