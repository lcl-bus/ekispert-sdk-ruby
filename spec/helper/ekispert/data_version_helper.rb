module Ekispert
  module SpecHelper
    module DataVersion
      def data_version_res_body
        <<~XML_TAG.gsub(/\n\s*/, '')
          <?xml version="1.0" encoding="UTF-8"?>
          <ResultSet apiVersion="1.26.0.0" engineVersion="201602_02a">
            <Version create="20160202" createType="Edition" caption="知識ベース"/>
            <Version create="20160202" createType="Edition" caption="鉄道時刻表"/>
            <Copyrights companyId="1" company="Example">ExampleText</Copyrights>
          </ResultSet>
        XML_TAG
      end

      def unexpected_res_body
        <<~XML_TAG.gsub(/\n\s*/, '')
          <?xml version="1.0" encoding="UTF-8"?>
          <ResultSet apiVersion="1.26.0.0" engineVersion="201602_02a">
            <Example>example</Example>
          </ResultSet>
        XML_TAG
      end
    end
  end
end
