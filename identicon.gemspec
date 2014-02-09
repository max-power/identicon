# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'identicon/version'

Gem::Specification.new do |spec|
  spec.name          = "identicon"
  spec.version       = Identicon::VERSION
  spec.authors       = ["Max Power"]
  spec.email         = ["kevin.melchert@gmail.com"]
  spec.summary       = %q{Github style Identicons.}
  spec.description   = %q{Built upon Ruby Matrix. Includes SVG, PNG, HTML and Plain Text renderers.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "chunky_png"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
