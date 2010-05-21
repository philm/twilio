module Twilio
  # This sub-resource represents only Toll Free phone numbers, or in other words, not local numbers. 
  # Also allows you to request a new toll free phone number be added to your account. 
  # Example:
  #   Twilio.connect('my_twilio_sid', 'my_auth_token')
  #   Twilio::TollFreePhoneNumber.list
  class TollFreePhoneNumber < TwilioObject
    def create(url, area_code = nil, method = 'POST', friendly_name = nil)
      Twilio.post("/IncomingPhoneNumbers/TollFree", :body => {
        :Url => url, 
        :AreaCode => area_code, 
        :Method => method,
        :FriendlyName => friendly_name 
      })
    end
    
    def list
      Twilio.get("/IncomingPhoneNumbers/TollFree")
    end
    
    def delete(phone_number_sid)
      Twilio.delete("/IncomingPhoneNumbers/#{phone_number_sid}")
    end
    
  end
end