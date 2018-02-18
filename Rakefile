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
    model = (ENV['model'] || :slow_verb).to_sym
    verses = (ENV['verses'] || 1).to_i

    bot = Bot.new(id: model, verses: verses)
    bot.tweet
  end
end

Sinatra::AssetPipeline::Task.define! Application
