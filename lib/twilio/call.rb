module Twilio
  class Call < TwilioObject
    def make(caller, called, url, optional = {})
      self.connection.class.post("/Calls", :body => {:Caller => caller, :Called => called, :Url => url}.merge(optional))
    end

    def list(optional = {})
      self.connection.class.get("/Calls", :query => optional)  
    end
        
    def get(call_sid)
      self.connection.class.get("/Calls/#{call_sid}")  
    end
    
    def segments(call_sid, call_segment_sid = nil)
      self.connection.class.get("/Calls/#{call_sid}/Segments#{ '/' + call_segment_sid if call_segment_sid }")
    end
    
    def recordings(call_sid)
      self.connection.class.get("/Calls/#{call_sid}/Recordings")
    end
    
    def notifications(call_sid)
      self.connection.class.get("/Calls/#{call_sid}/Notifications")
    end
  end
end