require 'spec_helper'

RSpec.describe Ekispert::Config do
  describe 'default config' do
    before do
      Ekispert::Config.set do |c|
        c.host = 'https://api.ekispert.jp'
        c.version = 'v1'
        c.http_proxy = ENV['http_proxy']
        c.api_key = ''
      end
    end
    it 'return default host' do
      expect(Ekispert::Config.host).to eq 'https://api.ekispert.jp'
    end
    it 'return default version' do
      expect(Ekispert::Config.version).to eq 'v1'
    end
    it 'return default http_proxy' do
      expect(Ekispert::Config.http_proxy).to eq ENV['http_proxy']
    end
    it 'return default api_key' do
      expect(Ekispert::Config.api_key).to eq ''
    end
  end
  describe '.list' do
    before do
      Ekispert::Config.set do |c|
        c.host = 'https://api.ekispert.jp'
        c.version = 'v1'
        c.http_proxy = ENV['http_proxy']
        c.api_key = ''
      end
    end
    it 'return config list' do
      expect(Ekispert::Config.list).to match(
        {
          :@host => 'https://api.ekispert.jp',
          :@version => 'v1',
          :@http_proxy => ENV['http_proxy'],
          :@api_key => ''
        }
      )
    end
  end
  describe '.set' do
    before do
      Ekispert::Config.set do |c|
        c.host = 'https://example.com'
        c.version = 'v2'
        c.http_proxy = 'http://example.com:8080'
        c.api_key = 'test'
      end
    end
    it 'can set the config with a block' do
      expect(Ekispert::Config.list).to match(
        {
          :@host => 'https://example.com',
          :@version => 'v2',
          :@http_proxy => 'http://example.com:8080',
          :@api_key => 'test'
        }
      )
    end
  end
end
