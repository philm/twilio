module Twilio
  # An OutgoingCallerId resource represents an outgoing Caller ID that you have 
  # registered with Twilio for use when making an outgoing call or using the Dial Verb.
  # Example:
  #   Twilio.connect('my_twilio_sid', 'my_auth_token')
  #   Twilio::OutgoingCallerId.list
  class OutgoingCallerId < TwilioObject
    def create(phone_number, friendly_name = phone_number, call_delay = 0, extension = nil)
      Twilio.post("/OutgoingCallerIds", :body => {
        :PhoneNumber => phone_number, 
        :FriendlyName => friendly_name, 
        :CallDelay => call_delay,
        :Extension => extension
      })
    end

    def list(opts = {})
      Twilio.get("/OutgoingCallerIds", :query => (opts.empty? ? nil : opts)) 
    end
        
    def get(callerid_sid)
      Twilio.get("/OutgoingCallerIds/#{callerid_sid}") 
    end
    
    def update_name(callerid_sid, name)
      Twilio.put("/OutgoingCallerIds/#{callerid_sid}", :body => {:FriendlyName => name})
    end
    
    def delete(callerid_sid)
      Twilio.delete("/OutgoingCallerIds/#{callerid_sid}")
    end
  end
end