module Twilio
  # An IncomingPhoneNumber resource represents a phone number given to you by 
  # Twilio to receive incoming phone calls. 
  class IncomingPhoneNumber < TwilioObject
    def list(optional = {})
      self.connection.class.get("/IncomingPhoneNumbers", :query => optional) 
    end
    
    def get(incoming_sid)
      self.connection.class.get("/IncomingPhoneNumbers/#{incoming_sid}") 
    end
  end
end