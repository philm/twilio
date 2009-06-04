module Twilio
  class IncomingPhoneNumber < TwilioObject
    def list(optional = {})
      self.connection.class.get("/IncomingPhoneNumbers", :query => optional) 
    end
    
    def get(incoming_sid)
      self.connection.class.get("/IncomingPhoneNumbers/#{incoming_sid}") 
    end
  end
end