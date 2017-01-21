# frozen_string_literal: true
require 'sequel'
require 'yard'

Sequel.extension :inflector

# The YARD base module
module YARD
  # The YARD handlers module
  module Handlers
    # The module for YARD ruby handlers
    module Ruby
      # Module for documenting Sequel code.
      # @author Kai Moschcau
      module Sequel
      end
    end
  end
end

require_relative 'yard-sequel/associations'
