require 'rubygems'
require 'cucumber'
require 'capybara/cucumber'
require 'webrick'
require 'json'
require 'couchrest'

# Setup capybara for using right driver
Capybara.default_driver = :selenium # or :culerity

# This maps to host for testing, but can be also set via step:
#   Given I am on "http://www.google.pl"
#

document_id = JSON.parse(File.read("config.js"))["id"]
database_url = JSON.parse(File.read(".couchapprc"))["env"]["cucumber"]["db"]
Capybara.app_host = "#{database_url}/#{document_id}".gsub(/\/\/.*@/,"//")

Capybara.default_selector = :css

# Extend Cucumber World with minitest assertions
World(MiniTest::Assertions)

def deploy_info(url)
  puts "deploy on: #{url.gsub(/^(https?:\/\/[^@:]+):[^@]+@/, '\1:******@')}"
end

Before do
  CouchRest.database!(database_url).delete!
  CouchRest.database!(database_url)

  url = "#{database_url}/_design/#{document_id}"
  deploy_info(url)

  system 'soca push cucumber'
end

After do
end
