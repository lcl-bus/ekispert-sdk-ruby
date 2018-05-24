module Ekispert
  class Client
    def self.get(path, params=nil)
      set_connection if @connection.nil? || connection_options_update?
      res = request(path, params)
      return parse_xml(res.body) if res.status == 200
      raise_error(res)
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

    def self.request(path, params)
      @connection.get(path.sub(/^\//, ''), params)
    end

    def self.parse_xml(xml)
      Nokogiri::XML.parse(xml).xpath('//ResultSet')
    end

    def self.raise_error(res)
      case res.status
      when 1
        raise InternalError, 'Engine Error'
      when 400
        raise BadRequest.new(res)
      when 403
        raise Forbidden.new(res)
      when 404
        raise NotFound.new(res)
      when 400..499
        raise ClientError.new(res)
      when 500..599
        raise ServerError.new('OMG!')
      else
      end
    end
  end
end
