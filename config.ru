require 'rubygems'
require 'bundler'

Bundler.require

use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: %i[get post]
  end
end

require 'sinatra/asset_pipeline'

%w[
  /models/**/*.rb
  /config/initializers/**/*.rb
  /lib/**/*.rb
]
  .map { |pattern| Dir[File.dirname(__FILE__) + pattern] }
  .flatten
  .each { |f| require(f) }

require './application'

run Application
