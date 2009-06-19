module Twilio
  # The Account resource represents your Twilio Account. 
  class Account < TwilioObject
    def get
      self.connection.class.get('')
    end
    
    def update_name(name)
      self.connection.class.put('', :body => {:FriendlyName => name})
    end
  end
end