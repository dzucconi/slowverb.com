module Twitter
  class << self
    def configure(id)
      Twitter::REST::Client.new do |config|
        config.consumer_key = ENV["#{id.to_s.upcase}_TWITTER_CONSUMER_KEY"]
        config.consumer_secret = ENV["#{id.to_s.upcase}_TWITTER_CONSUMER_SECRET"]
        config.access_token = ENV["#{id.to_s.upcase}_TWITTER_ACCESS_TOKEN"]
        config.access_token_secret = ENV["#{id.to_s.upcase}_TWITTER_ACCESS_TOKEN_SECRET"]
      end
    end
  end
end
