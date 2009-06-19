module Twilio
  # A Notification represenents a log entry made by Twilio in the course of handling 
  # your calls or using the REST API.
  class Notification < TwilioObject
    def list(optional = {})
      self.connection.class.get('/Notifications', :query => optional)
    end
    
    def get(notification_sid)
      self.connection.class.get("/Notifications/#{notification_sid}")
    end
    
    def delete(notification_sid)
      self.connection.class.delete("/Notifications/#{notification_sid}")
    end
  end
end