module Twilio
  # The Account resource represents your Twilio Account. 
  class Account < TwilioObject
    def get
      Twilio.get('') 
    end
    
    def update_name(name)
      Twilio.put('', :body => {:FriendlyName => name}) 
    end
  end
end