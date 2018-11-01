module Ekispert
  class Condition < EkispertBase
    extend Ekispert::ConditionDefiner

    def self.get(**params)
      to_condition(Ekispert::Client.get('toolbox/course/condition', params))
    end

    def self.to_condition(elem_arr)
      self.new(elem_arr.xpath('//Condition')[0])
    end

    # It create instance without api call.
    def self.generate(**params)
      # TODO: return same the #get value
    end

    private_class_method :to_condition
  end
end
