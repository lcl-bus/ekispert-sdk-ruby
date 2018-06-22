module Ekispert
  class Point
    class Station < Point
      attr_reader :name_list, :yomi_list, :type_list, :gate_group_list, :old_name_list

      def initialize(element)
        @name_list = []
        @yomi_list = []
        @type_list = []
        # when use addGateGroup param
        @gate_group_list = []
        # when use oldName param
        @old_name_list = []
        super(element)
      end

      class Name < EkispertBase; end
      class Yomi < EkispertBase; end
      class Type < EkispertBase; end
      class OldName < EkispertBase; end
      class GateGroup < EkispertBase
        attr_accessor :gate_list

        def initialize(element)
          @gate_list = []
          super(element)
        end

        class Gate < EkispertBase
          attr_accessor :name_list, :geo_point_list

          def initialize(element)
            @name_list = []
            @geo_point_list = []
            super(element)
          end

          class Name < EkispertBase; end
          class GeoPoint < EkispertBase; end
        end
      end

      def self.get(**params)
        convert_point_to_station(self.superclass.get_station(params))
      end

      private

      # argment:
      #   point_list: [#<Ekispert::Point>, #<Ekispert::Point>,...]
      # return:
      #   [#<Ekispert::Point::Station>, #<Ekispert::Point::Station>,...]
      # to be available:
      #   Point::Station#prefecture_list
      #   Point::Station#geo_point_list
      def self.convert_point_to_station(point_list)
        point_list.map do |point|
          station = point.station_list[0]
          station.prefecture_list = point.prefecture_list
          station.geo_point_list = point.geo_point_list
          station
        end
      end
    end
  end
end
