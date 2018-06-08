module Ekispert
  class Config
    DEFAULTS = {
      host: 'https://api.ekispert.jp',
      version: 'v1',
      http_proxy: ENV['HTTP_PROXY'],
      api_key: ENV['EKISPERT_API_KEY']
    }.freeze
    DEFAULTS.each do |option, value|
      class_eval %(
        class << self
          attr_accessor :#{option}
        end
      )
      instance_variable_set("@#{option}", value)
    end

    def self.list
      options = {}
      self.instance_variables.each do |name|
        options[name] = instance_variable_get(name)
      end
      options
    end

    def self.set
      yield self
    end
  end
end
