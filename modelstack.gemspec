# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'modelstack/version.rb'

Gem::Specification.new do |s|
  s.name        = 'modelstack'
  s.version     = ModelStack::VERSION
  s.authors     = ["Christoph Pageler"]
  s.email       = 'christoph.pageler@me.com'
  s.summary     = "Code generator"
  s.description = "Generates code for server and client applications"
  s.homepage    = 'http://christophpageler.de'
  s.license     = 'MIT'

  s.files       =  Dir["lib/**/*"] + %w( bin/modelstack README.md LICENSE )

  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'commander', '= 4.3.5' # CLI parser
  s.add_dependency 'colored' # coloured terminal output
  s.add_dependency 'terminal-table', '~> 1.4.5' # Actions documentation

  # Development only
  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'
end