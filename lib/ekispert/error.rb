module Ekispert
  class Error < StandardError
    class ClientError < Error
      def initialize(res)
        @res = res
        super(format_error_body)
      end

      private

      def format_error_body
        %(
            status  : #{@res.status}
            URL     : #{@res.env.url}
            message : #{split_message(@res.body).join("\n")}
          )
      end

      def split_message(res_body)
        Nokogiri::XML(res_body).xpath('/ResultSet/Error/Message').map(&:text)
      end
    end
    class InternalError < Error; end # 1
    class BadRequest < ClientError; end # 400
    class Forbidden < ClientError; end # 403
    class NotFound < ClientError; end # 404
    class ServerError < Error; end # 500..599
  end
end
