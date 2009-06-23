module Twilio
  # An IncomingPhoneNumber resource represents a phone number given to you by 
  # Twilio to receive incoming phone calls. 
  # Example:
  #   Twilio.connect('my_twilio_sid', 'my_auth_token')
  #   Twilio::IncomingPhoneNumber.list
  class IncomingPhoneNumber < TwilioObject
    def list(optional = {})
      Twilio.get("/IncomingPhoneNumbers", :query => optional) 
    end
    
    def get(incoming_sid)
      Twilio.get("/IncomingPhoneNumbers/#{incoming_sid}") 
    end
  end
end