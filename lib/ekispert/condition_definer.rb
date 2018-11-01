module Ekispert
  module ConditionDefiner
    # Set Ekispert::Conditiion constants and methods.
    def self.extended(condition_class)
      load_condition_data
      define_condition_methods
      condition_class.const_set(:T_DATA, @t_data)
      condition_class.const_set(:F_DATA, @f_data)
      condition_class.const_set(:A_DATA, @a_data)
      condition_class.const_set(:DEFAULT_PARAMS, default_params)
    end

    def self.load_condition_data
      data_path = './data/condition'
      @t_data = YAML.load_file("#{data_path}/traffic_data.yml")
      @f_data = YAML.load_file("#{data_path}/fee_data.yml")
      @a_data = YAML.load_file("#{data_path}/adjunctive_data.yml")
      @condition_list = YAML.load_file("#{data_path}/condition_list.yml")
    end

    # Define condition methods.
    # Ex. two condition. ( Such as shinkansen and localBus... )
    #  { 'two' => { 'never' => '1', 'normal' => '2' }
    #
    #  def two_condition
    #    { 'never' => '1', 'normal' => '2' }
    #  end
    def self.define_condition_methods
      @condition_list.each_pair { |name, condition| define_method("#{name}_condition") { condition } }
    end

    def self.default_params
      default_params = {}
      [@t_data, @f_data, @a_data].each do |category_data|
        category_data.each do |data|
          # obsolete or deprecated param.
          next if data['name'].nil?

          default_params[data['name']] = @condition_list[data['condition_type']].key(data['default_code'])
        end
      end
      default_params
    end
  end
end
