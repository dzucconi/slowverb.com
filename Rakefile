require 'sinatra/asset_pipeline/task'
require 'rubygems'
require 'bundler'

Bundler.require

require 'sinatra/asset_pipeline'

%w[
  /models/**/*.rb
  /config/initializers/**/*.rb
  /lib/**/*.rb
  /lib/**/*.rake
]
  .map { |pattern| Dir[File.dirname(__FILE__) + pattern] }
  .flatten
  .each { |f| require(f) }

require './application'

namespace :bot do
  task :tweet do
    model = ENV['model'].to_sym || :slow_verb
    verses = ENV['verses'].to_i || 1

    $twitter.update(MODELS[model].__verse__(verses),
      lat: 38.942,
      long: 1.40483
    )
  end
end

Sinatra::AssetPipeline::Task.define! Application
