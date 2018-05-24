module Ekispert
  module SpecHelper
    class ClientError
      attr_accessor :body, :status, :env
      def initialize(error_code)
        @body = <<~XML_TAG.gsub(/\n\s*/, '')
          <?xml version="1.0" encoding="UTF-8" standalone='yes'?>
          <ResultSet apiVersion="0.0.0.0" engineVersion="123456789">
            <Error code="W#{error_code}>
              <Message> Error Occurred</Message>
            </Error>
          </ResultSet>
        XML_TAG
        @status = error_code
        @env = Env.new
      end

      class Env
        attr_accessor :url
        def initialize
          @url = 'http://hpge/fuga'
        end
      end

      def self.res_error(error_code)
        error = self.new(error_code)
      end
    end
  end
end
