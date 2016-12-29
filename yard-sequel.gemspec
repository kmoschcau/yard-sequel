# coding: utf-8
require_relative 'lib/yard-sequel/version'

Gem::Specification.new do |spec|
  spec.name    = 'yard-sequel'
  spec.version = YARD::Handlers::Ruby::Sequel::VERSION
  spec.authors = 'Kai Moschcau'
  spec.email   = 'kai.moschcau@gmail.com'

  spec.summary     = 'Provides automatic YARD documentation for Sequel Gem'
  spec.description = 'This gem provides automatic YARD documentation for the '\
                     'Sequel Gem.'
  spec.homepage    = 'https://github.com/kmoschcau/yard-sequel'
  spec.license     = 'MIT'

  spec.required_ruby_version     = '~> 2.3'
  spec.required_rubygems_version = '~> 2.0'

  spec.files         = Dir['lib/**/*.rb'] + ['.yardopts']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'awesome_print', '~> 1.7'
  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'byebug', '~> 9.0'
  spec.add_development_dependency 'rake', '~> 11.3'

  spec.add_runtime_dependency 'sequel', '~> 4.41'
  spec.add_runtime_dependency 'yard', '~> 0.9'
end
