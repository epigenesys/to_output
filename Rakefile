require "rubygems"
require "bundler"
Bundler.setup

require "rake"
require "rspec/core/rake_task"

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "to_output"
    gem.summary = %Q{Attach to_output methods to all objects}
    gem.description = %Q{Attach to_output methods to all objects, providing neat display of types}
    gem.email = "glen@epigenesys.co.uk"
    gem.homepage = "http://github.com/epigenesys/to_output"
    gem.authors = ["Glen Mailer"]
    gem.add_development_dependency "rspec", ">= 2.0.0.rc"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

rspec_options = lambda do |task|
  task.pattern = "spec/*_spec.rb"
  task.fail_on_error = false
end

RSpec::Core::RakeTask.new(:spec) do |task|
  rspec_options.call(task)
end

desc "Run RSpec code examples and generate RCov coverage report"
RSpec::Core::RakeTask.new(:coverage) do |task|
  rspec_options.call(task)

  task.rcov = true
  task.rcov_opts = "--exclude spec,#{Gem.path.join(",")}"
end

namespace :coverage do
  desc "Clear the coverage data"
  task :clean do
    sh("rm -rf metrics/coverage/")
  end
end

task :spec => :check_dependencies

task :default => :spec
