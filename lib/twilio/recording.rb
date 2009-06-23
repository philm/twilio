module Twilio
  # Recordings are generated when you use the Record Verb. Those recordings are 
  # hosted on Twilio's REST API for you to access. 
  # Example:
  #   Twilio.connect('my_twilio_sid', 'my_auth_token')
  #   Twilio::Recording.list
  class Recording < TwilioObject    
    def list(optional = {})
      Twilio.get("/Recordings", :query => optional)  
    end
    
    def get(recording_sid)
      Twilio.get("/Recordings/#{recording_sid}")  
    end
    
    def delete(recording_sid)
      Twilio.delete("/Recordings/#{recording_sid}")
    end
    
    def transcriptions(recording_sid, transcription_sid = nil)
      Twilio.get("/Recordings/#{recording_sid}/Transcriptions#{ '/' + transcription_sid if transcription_sid }") 
    end
  end
end