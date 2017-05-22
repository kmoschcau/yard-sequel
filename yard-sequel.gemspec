# coding: utf-8
# frozen_string_literal: true

require_relative 'lib/yard-sequel/version'

Gem::Specification.new do |spec|
  spec.name    = 'yard-sequel'
  spec.version = YardSequel::VERSION
  spec.authors = 'Kai Moschcau'
  spec.email   = 'kai.moschcau@gmail.com'

  spec.summary     = 'Provides automatic YARD documentation for Sequel Gem'
  spec.description = 'This gem provides automatic YARD documentation for the '\
                     'Sequel Gem.'
  spec.homepage    = 'https://github.com/kmoschcau/yard-sequel'
  spec.license     = 'MIT'

  spec.files         = Dir['lib/**/*.rb'] + ['.yardopts']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop', '~> 0.48'

  spec.add_runtime_dependency 'sequel', '~> 4.0'
  spec.add_runtime_dependency 'yard', '~> 0.9'
end
