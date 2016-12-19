require 'sequel'
require 'yard'

Sequel.extension :inflector

module YARD
  module Handlers
    module Ruby
      # Module for documenting Sequel code.
      # @author Kai Moschcau
      module Sequel; end
    end
  end
end

require_relative 'yard-sequel/associations'
