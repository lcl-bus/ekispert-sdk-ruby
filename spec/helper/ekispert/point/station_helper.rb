module Ekispert
  module SpecHelper
    module Point
      module Station
        def tokyo_station
          <<~XML_TAG.gsub(/\n\s*/, '')
            <?xml version="1.0" encoding="UTF-8"?>
            <ResultSet apiVersion="1.14.0.0" engineVersion="201404_01a">
              <Point>
                <Station code="22828">
                  <Name>東京</Name>
                  <Yomi>とうきょう</Yomi>
                  <Type>train</Type>
                </Station>
                <Prefecture code="13">
                  <Name>東京都</Name>
                </Prefecture>
              </Point>
            </ResultSet>
          XML_TAG
        end

        def koenji_station_with_geopoint_and_gate_group
          <<~XML_TAG.gsub(/\n\s*/, '')
            <?xml version="1.0" encoding="UTF-8"?>
            <ResultSet apiVersion="1.14.0.0" engineVersion="201404_01a">
              <Point>
                <Station code="22671">
                  <Name>高円寺</Name>
                  <Type>train</Type>
                  <Yomi>こうえんじ</Yomi>
                  <GateGroup>
                    <Gate code="G3929">
                      <Name>南口</Name>
                      <GeoPoint longi="139.39.11.39" lati="35.42.6.99" longi_d="139.653166" lati_d="35.701943" gcs="tokyo"/>
                    </Gate>
                    <Gate code="G3930">
                      <Name>北口</Name>
                      <GeoPoint longi="139.39.11.79" lati="35.42.8.19" longi_d="139.653277" lati_d="35.702278" gcs="tokyo"/>
                    </Gate>
                  </GateGroup>
                </Station>
                <Prefecture code="13">
                  <Name>東京都</Name>
                </Prefecture>
                <GeoPoint longi="139.39.10.89" lati="35.42.7.59" longi_d="139.653027" lati_d="35.70211" gcs="tokyo"/>
              </Point>
            </ResultSet>
          XML_TAG
        end

        def old_station_name
          <<~XML_TAG.gsub(/\n\s*/, '')
            <ResultSet apiVersion="1.27.0.0" engineVersion="201805_03a">
              <Point>
                <Station code="22859">
                  <OldName>業平橋</OldName>
                  <Name>とうきょうスカイツリー</Name>
                  <Type>train</Type>
                  <Yomi>とうきょうすかいつりー</Yomi>
                </Station>
                <Prefecture code="13">
                  <Name>東京都</Name>
                </Prefecture>
                <GeoPoint longi="139.48.44.19" lati="35.42.25.59" longi_d="139.812278" lati_d="35.70711" gcs="tokyo"/>
              </Point>
            </ResultSet>
          XML_TAG
        end
      end
    end
  end
end
