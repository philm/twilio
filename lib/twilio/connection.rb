module Twilio
  include HTTParty
  TWILIO_URL = "https://api.twilio.com/2010-04-01/Accounts"
    
  # The connect method caches your Twilio account id and authentication token
  # Example:
  #  Twilio.connect('AC309475e5fede1b49e100272a8640f438', '3a2630a909aadbf60266234756fb15a0')
  def self.connect(account_sid, auth_token)
    self.base_uri "#{TWILIO_URL}/#{account_sid}"
    self.basic_auth account_sid, auth_token
  end
  
  # DEPRECATED - use Twilio.connect
  class Connection
    include HTTParty
    TWILIO_URL = "https://api.twilio.com/2008-08-01/Accounts"
    
    def initialize(account_sid, auth_token)
      self.class.base_uri "#{TWILIO_URL}/#{account_sid}"
      self.class.basic_auth account_sid, auth_token     
    end
  end
  
end
