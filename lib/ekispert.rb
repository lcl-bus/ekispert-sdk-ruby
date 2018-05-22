require 'faraday'
require 'faraday_middleware'
require 'nokogiri'

# require all files in the ./lib/ekispert directory
Dir.glob("#{File.dirname(__FILE__)}/ekispert/**/*.rb", &method(:require))
