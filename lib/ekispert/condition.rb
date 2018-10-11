module Ekispert
  class Condition  < EkispertBase

    def self.get(**params)
      to_condition(Ekispert::Client.get('toolbox/course/condition', params))
    end

    def self.to_condition(elem_arr)
      self.new(elem_arr.xpath('//Condition')[0])
    end
  end
end
