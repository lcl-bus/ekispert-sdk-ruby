module Ekispert
  class Config
    DEFAULTS = {
      host: 'https://api.ekispert.jp',
      version: 'v1',
      http_proxy: ENV['http_proxy'],
      api_key: ''
    }.freeze
    DEFAULTS.each do |option, value|
      class_eval %Q{
        class << self
          attr_accessor :#{option}
        end
      }
      instance_variable_set("@#{option}", value)
    end

    def self.list
      options = {}
      self.instance_variables.each do |name|
        options[name] = instance_variable_get(name)
      end
      options
    end

    def self.set(&block)
      yield self
    end
  end
end
