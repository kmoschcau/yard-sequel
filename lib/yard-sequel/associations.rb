# frozen_string_literal: true

module YardSequel
  # Module for documentation Sequel associations.
  # @author Kai Moschcau
  module Associations; end
end

require_relative 'associations/association_handler'
require_relative 'associations/modules'

require_relative 'associations/many_to_one_handler'
require_relative 'associations/one_to_many_handler'
