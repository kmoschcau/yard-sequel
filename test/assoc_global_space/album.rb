require 'sequel'

class Album < Sequel::Model
  many_to_one :artist
end
