# frozen_string_literal: true
require 'sequel'

class Artist < Sequel::Model
  one_to_many :albums
end
