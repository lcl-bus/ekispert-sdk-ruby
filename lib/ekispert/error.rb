module Ekispert
  class Error < StandardError
  end

  class ClientError < Error
    def initialize(res)
      binding.pry
      # res.env.url - url情報
      # res.status  - ステータスコード
=begin
  exp）TODO
  status : 404
  URL : http://~~~~~/aiueo
  message :
    ~~~~~
    ====
    ----
=end
      super(Nokogiri::XML(res.body).xpath('/ResultSet/Error/Message').map(&:text).join(', '))
    end
  end # 400..499
  class BadRequest < ClientError; end # 400
  class Forbidden < ClientError; end # 403
  class NotFound < ClientError; end # 404

  class ServerError < Error; end # 500..599
end
