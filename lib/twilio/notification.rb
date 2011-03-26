module Twilio
  # A Notification represenents a log entry made by Twilio in the course of handling 
  # your calls or using the REST API.
  # Example:
  #   Twilio.connect('my_twilio_sid', 'my_auth_token')
  #   Twilio::Notification.list
  class Notification < TwilioObject
    def list(opts = {})
      Twilio.get('/Notifications', :query => (opts.empty? ? nil : opts))
    end
    
    def get(notification_sid)
      Twilio.get("/Notifications/#{notification_sid}")
    end
    
    def delete(notification_sid)
      Twilio.delete("/Notifications/#{notification_sid}")
    end
  end
end