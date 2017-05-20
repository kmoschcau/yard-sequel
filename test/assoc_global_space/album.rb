# frozen_string_literal: true

require 'sequel'

# The Album test class.
class Album < Sequel::Model
  many_to_one :artist
end
