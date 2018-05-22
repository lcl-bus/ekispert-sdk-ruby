# frozen_string_literal: true
module Ekispert
  module SpecHelper
    module Information
      def res_body_rail
        <<~XML_TAG.gsub(/\n\s*/, '')
          <?xml version="1.0" encoding="UTF-8" standalone='yes'?>
          <ResultSet apiVersion="1.27.0.0" engineVersion="201805_03a">
            <Information>
              <Corporation index="1">
                <Name>ＪＲ</Name>
              </Corporation>
              <Type>rail</Type>
              <Line corporationIndex="1">
                <Name>ＪＲ新幹線のぞみ</Name>
                <Type detail="shinkansen">train</Type>
                <Color>051102255</Color>
              </Line>
            </Information>
          </ResultSet>
        XML_TAG
      end

      def res_body_rail_and_exit
        <<~XML_TAG.gsub(/\n\s*/, '')
          <?xml version="1.0" encoding="UTF-8" standalone='yes'?>
          <ResultSet apiVersion="1.27.0.0" engineVersion="201805_03a">
            <Information>
              <Corporation index="1">
                <Name>ＪＲ</Name>
              </Corporation>
              <Type>rail</Type>
              <Line corporationIndex="1">
                <Name>ＪＲ新幹線のぞみ</Name>
                <Type detail="shinkansen">train</Type>
                <Color>051102255</Color>
              </Line>
            </Information>
            <Information>
              <Type>exit</Type>
              <Exit>
                <Name>１出口</Name>
                <Comment>
                  （大手町方面） 三菱ＵＦＪ信託銀行本店ビル 日本工業倶楽部 丸の内永楽ビル 　ｉｉｙｏ！！（イーヨ！！） 　三井住友信託銀行本店ビル 　三菱ＵＦＪ銀行（新丸の内支店） 東京メトロ東西線大手町駅 銀行会館 三井住友銀行本店ビルディング パレスビル パレスホテル東京 大手門 永代通り 丸の内１丁目 大手町１・２丁目
                </Comment>
              </Exit>
            </Information>
          </ResultSet>
        XML_TAG
      end

      def res_body_same_elements
        <<~XML_TAG.gsub(/\n\s*/, '')
          <?xml version="1.0" encoding="UTF-8" standalone='yes'?>
          <ResultSet apiVersion="1.27.0.0" engineVersion="201805_03a">
            <Information>
              <Corporation index="1">
                <Name>ＪＲ</Name>
              </Corporation>
              <Type>rail</Type>
              <Line corporationIndex="1">
                <Name>ＪＲ新幹線のぞみ</Name>
                <Type detail="shinkansen">train</Type>
                <Color>051102255</Color>
              </Line>
            </Information>
            <Information>
              <Corporation index="1">
                <Name>ＪＲ</Name>
              </Corporation>
              <Type>nearrail</Type>
              <Line corporationIndex="1">
                <Name>ＪＲ新幹線のぞみ</Name>
                <Type detail="shinkansen">train</Type>
                <Color>051102255</Color>
              </Line>
            </Information>
          </ResultSet>
        XML_TAG
      end
    end
  end
end
