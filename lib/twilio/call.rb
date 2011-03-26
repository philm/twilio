module Twilio
    # A Call represenents a connection between a telephone and Twilio. This may be 
    # inbound, when a person calls your application, or outbound when your application 
    # initiates the call, either via the REST API, or during a call via the Dial Verb. 
  class Call < TwilioObject
    #  Example:
    #  Twilio.connect('my_twilio_sid', 'my_auth_token')
    #  Twilio::Call.make(CALLER_ID, user_number, 'http://myapp.com/twilio_response_handler')
    def make(from, to, url, opts = {})
      Twilio.post("/Calls", :body => {:From => from, :To => to, :Url => url}.merge(opts))
    end

    def list(opts = {})
      Twilio.get("/Calls", :query => (opts.empty? ? nil : opts))  
    end
        
    def get(call_sid)
      Twilio.get("/Calls/#{call_sid}")
    end
    
    def redirect(call_sid, new_url, url_action = 'POST')
      Twilio.post("/Calls/#{call_sid}", :body => {:CurrentUrl => new_url, :CurrentMethod => url_action})
    end
    
    def segments(call_sid, call_segment_sid = nil)
      Twilio.get("/Calls/#{call_sid}/Segments#{ '/' + call_segment_sid if call_segment_sid }")
    end
    
    def recordings(call_sid)
      Twilio.get("/Calls/#{call_sid}/Recordings")
    end
    
    def notifications(call_sid)
      Twilio.get("/Calls/#{call_sid}/Notifications")
    end
  end
end