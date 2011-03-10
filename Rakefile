require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'
require "launchy"

def deploy_info(url)
  puts "deploy on: #{url.gsub(/^(https?:\/\/[^@:]+):[^@]+@/, '\1:******@')}"
end

namespace :cucumber do

  Cucumber::Rake::Task.new(:ok, 'Run features that should pass') do |t|
    t.fork = true # You may get faster startup if you set this to false
    t.profile = 'default'
  end

  Cucumber::Rake::Task.new(:wip, 'Run features that are being worked on') do |t|
    t.fork = true # You may get faster startup if you set this to false
    t.profile = 'wip'
  end

  Cucumber::Rake::Task.new(:rerun, 'Record failing features and run only them if any exist') do |t|
    t.fork = true # You may get faster startup if you set this to false
    t.profile = 'rerun'
  end

  desc 'Run all features'
  task :all => [:ok, :wip]

  desc "Remove all temp file."
  task :clean do
    system "rm capybara-*.html cucumber.log"
  end
end

namespace :spec do
  task :spec do
    document_id = JSON.parse(File.read("config.js"))["id"]
    database_url = JSON.parse(File.read(".couchapprc"))["env"]["spec"]["db"]

    url = "#{database_url}/_design/#{document_id}"
    deploy_info(url)

    system 'soca push spec'

    spec = "#{url}/spec/spec.html"
    Launchy.open spec.gsub(/^(https?:\/\/)([^@:]+):[^@]+@/, '\1')
  end

  desc 'Run autospecs'
  task :auto do
    document_id = JSON.parse(File.read("config.js"))["id"]
    database_url = JSON.parse(File.read(".couchapprc"))["env"]["spec"]["db"]

    url = "#{database_url}/_design/#{document_id}"
    deploy_info(url)

    system 'soca push spec'

    spec = "#{url}/spec/spec.html"
    Launchy.open spec.gsub(/^(https?:\/\/)([^@:]+):[^@]+@/, '\1')
    system 'soca autopush spec'
  end
end

desc 'Alias for cucumber:ok'
task :cucumber => 'cucumber:ok'

desc 'Run all specs'
task :spec => 'spec:spec'

task :default => [:cucumber, :spec]

namespace :open do
  task :open do
    document_id = JSON.parse(File.read("config.js"))["id"]
    database_url = JSON.parse(File.read(".couchapprc"))["env"]["default"]["db"]

    url = "#{database_url}/_design/#{document_id}"
    deploy_info(url)

    system 'soca push'

    index = "#{url}/index.html"
    Launchy.open index.gsub(/^(https?:\/\/)([^@:]+):[^@]+@/, '\1')
  end

  desc 'Run auto deployment for development'
  task :auto do
    document_id = JSON.parse(File.read("config.js"))["id"]
    database_url = JSON.parse(File.read(".couchapprc"))["env"]["default"]["db"]

    url = "#{database_url}/_design/#{document_id}"
    deploy_info(url)

    system 'soca push'

    index = "#{url}/index.html"
    Launchy.open index.gsub(/^(https?:\/\/)([^@:]+):[^@]+@/, '\1')
    system 'soca autopush'
  end
end

desc 'Run development version'
task :open => "open:open"
