# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name        = 'finicity'
  s.version     = '0.1.0'
  s.date        = '2015-04-14'
  s.summary     = "Finicity api gem"
  s.description = "A simple to use ruby wrapper for Fincity API."
  s.authors     = ["James Rhodes"]
  s.email       = 'james@somehero.com'
  s.homepage    =
    'https://github.com/somehero'
  s.license       = 'MIT'
  s.add_runtime_dependency "rest-client"
  s.add_runtime_dependency "json"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
end
