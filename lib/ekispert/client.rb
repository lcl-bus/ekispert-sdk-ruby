module Ekispert
  class Client
    def self.get(path, params=nil)
      set_connection if @connection.nil? || connection_options_update?
      res = @connection.get(path, params)
    end

    def self.connection_options
      {
        url: "#{Config.host}/#{Config.version}/xml",
        proxy: Config.http_proxy,
        headers: { 'Content-Type' => 'application/xml;charset=utf-8' },
        params: { key: Ekispert::Config.api_key },
        request: { timeout: 5, open_timeout: 2 }
      }
    end

    private
    def self.set_connection
      @connection_options = connection_options
      @connection = Faraday.new(@connection_options) do |c|
        c.adapter Faraday.default_adapter
      end
    end

    def self.connection_options_update?
      @connection_options != connection_options
    end
  end
end
