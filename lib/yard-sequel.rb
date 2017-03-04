# frozen_string_literal: true
require 'sequel'
require 'yard'

Sequel.extension :inflector

# Module for documenting Sequel code.
# @author Kai Moschcau
module YardSequel; end

require_relative 'yard-sequel/associations'
require_relative 'yard-sequel/ast_hash'
