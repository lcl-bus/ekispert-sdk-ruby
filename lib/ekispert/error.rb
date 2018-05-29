module Ekispert
  class Error < StandardError; end

  class ClientError < Error
    def initialize(res)
      error_body = <<-EOS
        \n
        status  : #{res.status}
        URL     : #{res.env.url}"
        message : #{Nokogiri::XML(res.body).xpath('/ResultSet/Error/Message').map(&:text).join("\n")}
      EOS
      super(error_body)
    end
  end
  class InternalError < Error; end # 1
  class BadRequest < ClientError; end # 400
  class Forbidden < ClientError; end # 403
  class NotFound < ClientError; end # 404
  class ServerError < Error; end # 500..599
end
