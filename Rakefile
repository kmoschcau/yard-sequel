require 'rake/clean'
task :default => :build

spec_file_name = Dir['*.gemspec'].first
spec           = Gem::Specification::load(spec_file_name)

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

namespace :push do
  task normal: :build do
    sh "bundle exec gem inabox pkg/#{spec.name}-#{spec.version}.gem --host #{spec.metadata['allowed_push_host']}"
  end
  
  desc "Push #{spec.name}-#{spec.version}.gem to #{spec.metadata['allowed_push_host']} and overwrite existing gem."
  task overwrite: :build do
    sh "bundle exec gem inabox pkg/#{spec.name}-#{spec.version}.gem --host #{spec.metadata['allowed_push_host']} --overwrite"
  end
end

desc "Push #{spec.name}-#{spec.version}.gem to #{spec.metadata['allowed_push_host']}"
task push: 'push:normal'

desc "Create a git tag 'v#{spec.version}' and push to origin."
task :tag do
  sh "git tag v#{spec.version}"
  sh 'git push --tags'
end
