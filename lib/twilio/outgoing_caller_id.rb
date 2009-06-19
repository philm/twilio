module Twilio
  # An OutgoingCallerId resource represents an outgoing Caller ID that you have 
  # registered with Twilio for use when making an outgoing call or using the Dial Verb. 
  class OutgoingCallerId < TwilioObject
    def create(phone_number, friendly_name = phone_number, call_delay = 0)
      self.connection.class.post("/OutgoingCallerIds", :body => {
        :PhoneNumber => phone_number, 
        :FriendlyName => friendly_name, 
        :CallDelay => call_delay 
      })
    end

    def list(optional = {})
      self.connection.class.get("/OutgoingCallerIds", :query => optional) 
    end
        
    def get(callerid_sid)
      self.connection.class.get("/OutgoingCallerIds/#{callerid_sid}") 
    end
    
    def update_name(callerid_sid, name)
      self.connection.class.put("/OutgoingCallerIds/#{callerid_sid}", :body => {:FriendlyName => name})
    end
    
    def delete(callerid_sid)
      self.connection.class.delete("/OutgoingCallerIds/#{callerid_sid}")
    end
  end
end