# frozen_string_literal: true
module YARD
  module Handlers
    module Ruby
      module Sequel
        # Module for documention Sequel associations.
        # @author Kai Moschcau
        module Associations
        end
      end
    end
  end
end

require_relative 'associations/association_handler'
require_relative 'associations/mixins'

require_relative 'associations/many_to_one_handler'
require_relative 'associations/one_to_many_handler'
