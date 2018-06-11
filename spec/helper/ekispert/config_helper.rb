module Ekispert
  module SpecHelper
    module Config
      def set_ekispert_config(
          host: 'https://api.ekispert.jp',
          version: 'v1',
          http_proxy: ENV['HTTP_PROXY'],
          api_key: ENV['EKISPERT_API_KEY']
      )
        Ekispert::Config.set do |c|
          c.host = host
          c.version = version
          c.http_proxy = http_proxy
          c.api_key = api_key
        end
      end
      alias :set_ekispert_default_config :set_ekispert_config
    end
  end
end
