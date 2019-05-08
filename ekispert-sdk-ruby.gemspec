lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ekispert/version'

Gem::Specification.new do |spec|
  spec.name          = 'ekispert'
  spec.version       = Ekispert::VERSION
  spec.authors       = ['Ekispert Web Service']

  spec.summary       = 'Ekispert API Client'
  spec.description   = 'wrapper for the Ekispert API'
  spec.homepage      = 'https://github.com/EkispertWebService/ekispert-sdk-ruby/'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'faraday', ['>= 0.7.4', '< 1.0']
  spec.add_dependency 'faraday_middleware', '~> 0.12.2'
  spec.add_dependency 'nokogiri', '~> 1.8.2'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.59.0'
end
