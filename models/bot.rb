require 'byebug'
class Bot
  attr_reader :id, :client
  attr_accessor :verses

  def initialize(id:, verses:)
    @id = id
    @verses = verses
    @client = Twitter.configure(id)
  end

  def tweet
    @client.update(MODELS[@id].__verse__(@verses))
  end
end
