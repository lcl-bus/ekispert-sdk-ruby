require 'spec_helper'

RSpec.describe Ekispert::Config do
  include Ekispert::SpecHelper::Config
  before { set_ekispert_default_config }
  describe 'default config' do
    it 'return default host' do
      expect(Ekispert::Config.host).to eq 'https://api.ekispert.jp'
    end
    it 'return default version' do
      expect(Ekispert::Config.version).to eq 'v1'
    end
    it 'return default http_proxy' do
      expect(Ekispert::Config.http_proxy).to eq ENV['HTTP_PROXY']
    end
    it 'return default api_key' do
      expect(Ekispert::Config.api_key).to eq ENV['EKISPERT_API_KEY']
    end
  end
  describe '.list' do
    it 'return config list' do
      expect(Ekispert::Config.list).to match(
        :@host => 'https://api.ekispert.jp',
        :@version => 'v1',
        :@http_proxy => ENV['HTTP_PROXY'],
        :@api_key => ENV['EKISPERT_API_KEY']
      )
    end
  end
  describe '.set' do
    before do
      set_ekispert_config(
        host: 'https://example.com',
        version: 'v2',
        http_proxy: 'http://example.com:8080',
        api_key: 'test'
      )
    end
    it 'can set the config with a block' do
      expect(Ekispert::Config.list).to match(
        :@host => 'https://example.com',
        :@version => 'v2',
        :@http_proxy => 'http://example.com:8080',
        :@api_key => 'test'
      )
    end
  end
end
