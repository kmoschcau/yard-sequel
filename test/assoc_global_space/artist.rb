# frozen_string_literal: true

require 'sequel'

# The Artist test class.
class Artist < Sequel::Model
  def foobar
  end

  # @!method albums
  #   @return [Array<Album>] the albums.
  one_to_many :albums

  # @return [Test::Moo::Bar] whatever
  one_to_many(
    :foo,
    {class:           :Bar,
     class_namespace: :'Test::Moo',
     :key          => :col1,
     primary_key:     :col2}
  )

  # @return [Moo::Test::Bar] whatever
  one_to_many(
    :bar,
    {class:       :'Moo::Test::Bar',
     key:         :col1,
     primary_key: :col2}
  )
end
