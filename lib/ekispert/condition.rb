module Ekispert
  class Condition < EkispertBase
    extend Ekispert::ConditionDefiner
    attr_accessor :params, :text

    def initialize(element=nil)
      @params = DEFAULT_PARAMS.clone
      super(element) if element
    end

    def self.get(**params)
      to_condition(Ekispert::Client.get('toolbox/course/condition', params))
    end

    def self.to_condition(elem_arr)
      self.new(elem_arr.xpath('//Condition')[0])
    end

    # It create instance without api call.
    def self.generate(**params)
      # TODO: return same the #get value
      condition = self.new

      # Convert @params to detail code. and set @text.
      condition.text = condition.convert_params_to_detail
      condition.symbolize_params_keys

      condition
    end

    private_class_method :to_condition

    # Convert @params to detail code.(@text)
    # Ex.
    #   instance.text #=> 'T2112122121229:F111212121100:A12212212:'
    #   instance.params #=> {
    #     'plane' => 'bit',
    #     'shinkansen' => 'never'
    #     ...
    #   }
    def convert_params_to_detail
      %w[T F A].inject('') { |detail, initial| "#{detail}#{set_detail_by_params(initial)}:" }
    end

    def symbolize_params_keys
      @params = @params.map { |k, v| [k.to_sym, v] }.to_h
    end

    private

    # Get and Set detail code from @params
    def set_detail_by_params(initial)
      category_data = self.class.const_get("#{initial}_DATA")
      detail_code = initial

      # Ex. When category is Traffic.
      #   detail_code #=> 'T'
      #   detail_code #=> 'T2'
      #   detail_code #=> 'T21' ....
      category_data.inject(detail_code) do |detail, data|
        if data['name']
          # Get and merge code from condition category methods.
          # Ex. When condition_data[0]（plane）, { 'plane' => 'bit' }
          #   "T#{get_code('bit', 'two_conditiion')}"
          "#{detail}#{get_code(@params[data['name']], data['condition_type'])}"
        else
          # Merge default code when code is obsolete or deprecated.
          "#{detail}#{data['default_code']}"
        end
      end
    end

    # Call conditiion method and get code.
    # ('0' is for JRReservation.)
    def get_code(value_name, condition_type)
      self.class.send("#{condition_type}_condition")[value_name] || '0'
    end
  end
end
