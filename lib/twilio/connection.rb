module Twilio
  # The Connection class caches the Twilio API base path and authentication credentials.
  # It is passed into the constructor of other TwilioObject's, avoiding the need to 
  # explicitly set credentials with each API call.
  #
  #  Example:
  #  c = Twilio::Connection.new('my_twilio_sid', 'my_auth_token')
  class Connection
    include HTTParty
    TWILIO_URL = "https://api.twilio.com/2008-08-01/Accounts"
    
    def initialize(account_sid, auth_token)
      self.class.base_uri "#{TWILIO_URL}/#{account_sid}"
      self.class.basic_auth account_sid, auth_token     
    end
  end
end