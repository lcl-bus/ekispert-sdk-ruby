module Ekispert
  class Condition < EkispertBase
    extend Ekispert::ConditionDefiner
    attr_accessor :params, :text

    def initialize(element=nil)
      @params = DEFAULT_PARAMS.clone
      super(element) if element
    end

    def self.get(params={})
      to_condition(Ekispert::Client.get('toolbox/course/condition', params))
    end

    def self.to_condition(elem_arr)
      condition = self.new(elem_arr.xpath('//Condition')[0])
      condition.convert_detail_to_params
      condition.symbolize_params_keys
      condition
    end

    # It create instance without api call.
    # 1. Update @params from detail.
    # 2. Update @params from argument params.
    # 3. Set text. (detail code)
    # 4. Symbolize @params keys.
    # 5. return Ekispert::Condition instance.
    def self.generate(params={})
      condition = self.new

      # Convert detail code to @params when params include :detail.
      # Ex.
      #   :detail => 'T2112122121229:F111212121100:A12212212:'
      #   instance.params = {
      #     'plane' => 'bit',
      #     'shinkansen' => 'never'
      #     ...
      #   }
      condition.text = params.delete(:detail)
      condition.convert_detail_to_params if condition.text

      # Update @params from params arguments.
      # params = { plane: 'normal' }
      # instance.params = {
      #   'plane' => 'normal',
      #   'shinkansen' => 'never'
      #   ...
      # }
      params.each_pair { |key, value| condition.update_params(key, value) }

      # Convert @params to detail code. and set @text.
      condition.text = condition.convert_params_to_detail
      condition.symbolize_params_keys

      condition
    end

    private_class_method :to_condition

    def update(params={})
      params.delete(:detail) # Use self#text

      # Update @params
      stringize_params_keys
      params.each_pair { |key, value| update_params(key, value) }

      # Update detail code(@text)
      @text = convert_params_to_detail
      symbolize_params_keys

      self
    end

    # Convert detail code(@text) to @params.
    # Ex.
    #   instance.text => 'T2112122121229:F111212121100:A12212212:'
    #   instance.params = {
    #     'plane' => 'bit',
    #     'shinkansen' => 'never'
    #     ...
    #   }
    def convert_detail_to_params
      # ['T2112122121229', 'F111212121100', 'A12212212']
      detail_codes = text.split(/([TFA]\d+):/).reject(&:empty?)
      detail_codes.each { |detail_code| set_params_by_detail(detail_code) }
    end

    def update_params(key, value)
      key = snakecase(key)
      @params[key] = value
    end

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

    def stringize_params_keys
      @params = @params.map { |k, v| [k.to_s, v] }.to_h
    end

    private

    # Set @params by detail code.
    def set_params_by_detail(code)
      category_data = self.class.const_get("#{code[0]}_DATA")
      category_data.each.with_index(1) do |data, i|
        next if data['name'].nil?

        # Ex. When category_data[1], code #=> 'T2112122121229'
        #   @params['shinkansen'] = two_condition.key('1')
        #   -> @params['shinkansen'] = { 'never' => '1', 'normal' => '2' }.key('1')
        #   -> @params['shinkansen'] = 'never'
        @params[data['name']] = self.class.send("#{data['condition_type']}_condition").key(code[i])
      end
    end

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
