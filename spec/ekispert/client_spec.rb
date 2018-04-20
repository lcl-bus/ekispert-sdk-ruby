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
end
