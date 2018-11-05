module Ekispert
  class Point::Station::GateGroup < EkispertBase
    attr_accessor :gate_list

    def initialize(element)
      @gate_list = []
      super(element)
    end
  end
end
