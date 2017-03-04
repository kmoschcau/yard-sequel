# frozen_string_literal: true

module YardSequel
  # The major version number.
  # Used for changes that are not backwards compatible.
  V_MAJOR = 0

  # The minor version number.
  # Used for changes that are backwards compatible.
  V_MINOR = 1

  # The build version number.
  # Used for internal changes.
  V_BUILD = 0

  # The version of the Sequel models.
  VERSION = Gem::Version.new("#{V_MAJOR}.#{V_MINOR}.#{V_BUILD}")
end
