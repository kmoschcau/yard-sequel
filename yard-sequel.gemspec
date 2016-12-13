# coding: utf-8
require_relative 'lib/yard-sequel/version'

Gem::Specification.new do |spec|
  spec.name    = 'yard-sequel'
  spec.version = YARD::Sequel::VERSION
  spec.authors = 'Kai Moschcau'
  spec.email   = 'kai.moschcau@gmail.com'
  
  spec.summary     = 'Provides automatic YARD documentation for Sequel DSL'
  spec.description = 'This gem provides automatic YARD documentation for the Sequel DSL.'
  # spec.homepage    = "TODO: Put your gem's website or public repo URL here."
  spec.license     = 'MIT'
  
  spec.required_ruby_version     = '~> 2.3'
  spec.required_rubygems_version = '~> 2.0'
  
  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  # end
  
  spec.files         = Dir['lib/**/*.rb'] + ['.yardopts']
  spec.require_paths = ['lib']
  
  spec.add_development_dependency 'awesome_print', '~> 1.7'
  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'byebug', '~> 9.0'
  spec.add_development_dependency 'rake', '~> 11.3'
  
  spec.add_runtime_dependency 'sequel', '~> 4.41'
  spec.add_runtime_dependency 'yard', '~> 0.9'
end
