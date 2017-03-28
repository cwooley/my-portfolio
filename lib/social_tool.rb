module SocialTool

  
  def self.twitter_search(hashtag)
    client = twitter_auth
    
    client.search(make_hashtag(hashtag), result_type: "recent").take(6).collect do |tweet|
      "#{tweet.user.screen_name}: #{tweet.text}"
    end
  end
  
  def self.twitter_auth
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV.fetch("TWITTER_CONSUMER_KEY")
      config.consumer_secret     = ENV.fetch("TWITTER_CONSUMER_SECRET")
      config.access_token        = ENV.fetch("TWITTER_ACCESS_TOKEN")
      config.access_token_secret = ENV.fetch("TWITTER_ACCESS_TOKEN_SECRET")
    end
    client
  end
  
  def self.make_hashtag(string)
    hashtag = "#" + string
    hashtag
  end
end