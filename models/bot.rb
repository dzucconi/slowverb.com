require 'cgi'

class Bot
  attr_reader :id, :client
  attr_accessor :verses

  def initialize(id:, verses:)
    @id = id
    @verses = verses
    @client = Twitter.configure(id)
  end

  def tweet
    msg = CGI.unescapeHTML(MODELS[@id].verse(@verses))
    @client.update(msg)
  end
end
