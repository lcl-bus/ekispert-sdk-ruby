module Ekispert
  class Point
    class Station < Point
      attr_reader :name_list, :yomi_list, :type_list, :gate_group_list

      PAID_REQUEST_PARAMS = [
        :oldName, :corporationName, :railName, :operationLineCode,
        :offset, :limit, :direction, :addGateGroup, :gcs
      ].freeze

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
    end
  end
end
