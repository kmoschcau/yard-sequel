require 'awesome_print'
require 'byebug'
require 'sequel'
require 'yard'

Sequel.extension :inflector

module YARD::Handlers::Ruby::Sequel
end

require_relative 'yard-sequel/associations'
