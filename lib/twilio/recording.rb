module Twilio
  # Recordings are generated when you use the Record Verb. Those recordings are 
  # hosted on Twilio's REST API for you to access. 
  class Recording < TwilioObject    
    def list(optional = {})
      self.connection.class.get("/Recordings", :query => optional)  
    end
    
    def get(recording_sid)
      self.connection.class.get("/Recordings/#{recording_sid}")  
    end
    
    def delete(recording_sid)
      self.connection.class.delete("/Recordings/#{recording_sid}")
    end
    
    def transcriptions(recording_sid, transcription_sid = nil)
      self.connection.class.get("/Recordings/#{recording_sid}/Transcriptions#{ '/' + transcription_sid if transcription_sid }") 
    end
  end
end