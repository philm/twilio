module Twilio
  # An IncomingPhoneNumber resource represents a phone number given to you by 
  # Twilio to receive incoming phone calls. 
  # Example:
  #   Twilio.connect('my_twilio_sid', 'my_auth_token')
  #   Twilio::IncomingPhoneNumber.list
  class IncomingPhoneNumber < TwilioObject
    def list(opts = {})
      Twilio.get("/IncomingPhoneNumbers", :query => (opts.empty? ? nil : opts)) 
    end
    
    def get(incoming_sid)
      Twilio.get("/IncomingPhoneNumbers/#{incoming_sid}") 
    end
    
    # Creates a phone number in Twilio. You must first find an existing number using
    # the AvailablePhoneNumber class before creating one here.
    #
    # Required: you must either set PhoneNumber or AreaCode as a required option
    # For additional options, see http://www.twilio.com/docs/api/rest/incoming-phone-numbers
    def create(opts)
      raise "You must set either :PhoneNumber or :AreaCode" if !opts.include?(:AreaCode) && !opts.include?(:PhoneNumber)
      Twilio.post("/IncomingPhoneNumbers", :body => opts)
    end
    
    def update(incoming_sid, opts)
      Twilio.post("/IncomingPhoneNumbers/#{incoming_sid}", :body => opts)
    end
    
    def delete(incoming_sid)
      Twilio.delete("/IncomingPhoneNumbers/#{incoming_sid}")
    end
  end
end