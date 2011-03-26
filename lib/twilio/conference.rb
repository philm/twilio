module Twilio
    # The Conference REST resource allows you to query and manage the state of conferences.
    # When a caller joins a conference via the Dial verb and Conference noun,
    # a Conference Instance Resource is created to represent the conference room
    # and a Participant Instance Resource is created to represent the caller who joined.
  class Conference < TwilioObject
    def list(opts = {})
      Twilio.get("/Conferences", :query => (opts.empty? ? nil : opts))
    end
    
    def get(conference_sid)
      Twilio.get("/Conferences/#{conference_sid}")
    end
    
    def participants(conference_sid, opts = {})
      Twilio.get("/Conferences/#{conference_sid}/Participants", :query => (opts.empty? ? nil : opts))
    end
    
    def participant(conference_sid, call_sid)
      Twilio.get("/Conferences/#{conference_sid}/Participants/#{call_sid}")
    end
    
    def mute_participant(conference_sid, call_sid)
      Twilio.post("/Conferences/#{conference_sid}/Participants/#{call_sid}", :body => {:Muted => true})
    end
    
    def unmute_participant(conference_sid, call_sid)
      Twilio.post("/Conferences/#{conference_sid}/Participants/#{call_sid}", :body => {:Muted => false})
    end
    
    def kick_participant(conference_sid, call_sid)
      Twilio.delete("/Conferences/#{conference_sid}/Participants/#{call_sid}")
    end
  end
end