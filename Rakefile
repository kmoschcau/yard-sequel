# frozen_string_literal: true

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new

task default: [:spec]

require 'rake/clean'

spec_file_name = Dir['*.gemspec'].first
spec           = Gem::Specification.load(spec_file_name)

directory 'pkg'

gem_file_base_name = "#{spec.name}-#{spec.version}.gem"
target_gem_file    = "pkg/#{gem_file_base_name}"

file target_gem_file => ['pkg'] + spec.files do
  sh "gem build #{spec_file_name}"
  mv(gem_file_base_name, 'pkg/')
end

CLOBBER.include(Dir['pkg/*.gem'])

desc "Build gem file: #{target_gem_file}"
task build: target_gem_file

desc "Install #{spec.name} #{spec.version} locally."
task install: :build do
  sh "gem install #{target_gem_file}"
end

desc "Create a git tag 'v#{spec.version}' and push to origin."
task :tag do
  sh "git tag v#{spec.version}"
  sh 'git push --tags'
end

desc "Publish #{spec.name} #{spec.version} to RubyGems.org."
task publish: :build do
  sh "gem push #{target_gem_file}"
end
