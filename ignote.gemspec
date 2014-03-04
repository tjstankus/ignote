# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ignote/version'

Gem::Specification.new do |spec|
  spec.name          = "ignote"
  spec.version       = Ignote::VERSION
  spec.authors       = ["TJ Stankus"]
  spec.email         = ["tjstankus@gmail.com"]
  spec.summary       = %q{Do stuff with kindle notes. }
  spec.description   = %q{Do more descriptive stuff with kindle notes.}
  spec.homepage      = "https://github.com/tjstankus/ignote"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '1.6.0.rc'
  spec.add_development_dependency 'rake', '~> 10.1'
  spec.add_development_dependency 'rspec', '3.0.0.beta2'
  spec.add_development_dependency 'pry', '~> 0.9.12.6'
  spec.add_development_dependency 'pry-debugger', '0.2.2'
end
