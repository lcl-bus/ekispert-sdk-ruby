module Ekispert
  class Client
    def self.connection_options
      {
        url: "#{Config.host}/#{Config.version}/xml",
        proxy: Config.http_proxy,
        headers: { 'Content-Type' => 'application/xml;charset=utf-8' },
        params: { key: Ekispert::Config.api_key },
        request: { timeout: 5, open_timeout: 2 }
      }
    end
  end
end
