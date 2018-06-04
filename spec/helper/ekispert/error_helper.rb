module Ekispert
  module SpecHelper
    module Error
      def test_faraday
        errors = [
          { status: 1, url: '/internalerror' },
          { status: 400, url: '/badrequest' },
          { status: 403, url: '/forbidden' },
          { status: 450, url: '/clienterror' },
          { status: 500, url: '/servererror' }
        ]
        Faraday.new do |conn|
          conn.adapter :test, Faraday::Adapter::Test::Stubs.new do |stub|
            errors.each do |error|
              stub.get(error[:url]) do
                [error[:status], error_header, error_body]
              end
            end
            stub.get('/raiseerrors') do
              [400, error_header, errors_body]
            end
          end
        end
      end

      def error_header
        { 'access-control-allow-origin' => '*', 'content-type' => 'application/xml;charset=utf-8', 'date' => 'Thu, 31 May 2018 00:00:00 GMT', 'status' => '999 error', 'x-content-type-options' => 'nosniff', 'content-length' => '000', 'connection' => 'Close' }
      end

      def error_body
        <<~XML_TAG.gsub(/\n\s*/, '')
          <?xml version="1.0" encoding="UTF-8" standalone='yes'?>
          <ResultSet apiVersion="1.23.4.5" engineVersion="1234_56a">
            <Error code="xxx">
              <Message>First row error</Message>
              <Message>Second row error</Message>
            </Error>
          </ResultSet>
        XML_TAG
      end

      def errors_body
        <<~XML_TAG.gsub(/\n\s*/, '')
          <?xml version="1.0" encoding="UTF-8" standalone='yes'?>
          <ResultSet apiVersion="1.23.4.5" engineVersion="1234_56a">
            <Error code="xxx">
              <Message>First row error</Message>
              <Message>Second row error</Message>
              <Message>Third row error</Message>
              <Message>Fourth row error</Message>
            </Error>
          </ResultSet>
        XML_TAG
      end
    end
  end
end
