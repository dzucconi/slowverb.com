require 'sinatra/asset_pipeline/task'
require 'rubygems'
require 'bundler'

Bundler.require

require 'sinatra/asset_pipeline'

%w(
  /models/**/*.rb
  /config/initializers/**/*.rb
  /lib/**/*.rb
)
  .map { |pattern| Dir[File.dirname(__FILE__) + pattern] }
  .flatten
  .each { |f| require(f) }

require './application'

Sinatra::AssetPipeline::Task.define! Application
