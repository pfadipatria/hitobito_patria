#!/usr/bin/env rake

begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

ENGINE_PATH = File.expand_path('..', __FILE__)
load File.expand_path('../app_root.rb', __FILE__)

load 'wagons/wagon_tasks.rake'

load 'rspec/rails/tasks/rspec.rake'

unless Rails.env == 'production'
  require 'ci/reporter/rake/rspec'
  require 'rubocop/rake_task'

  Rubocop::RakeTask.new
end

HitobitoPatria::Wagon.load_tasks

task 'test:prepare' => 'db:test:prepare'
