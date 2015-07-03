require 'rubygems'
require 'bundler'

Bundler.require

require 'sinatra/asset_pipeline'

%w(
  /config/initializers/**/*.rb
  /lib/**/*.rb
)
  .collect { |pattern| Dir[File.dirname(__FILE__) + pattern] }
  .flatten.each { |f| require(f) }

require './application'

run Application
