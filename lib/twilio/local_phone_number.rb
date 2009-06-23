module Twilio
  # This sub-resource represents only Local phone numbers, or in other words, not toll-free numbers. 
  # Also allows you to request a new local phone number be added to your account.
  # Example:
  #   Twilio.connect('my_twilio_sid', 'my_auth_token')
  #   Twilio::LocalPhoneNumber.list
  class LocalPhoneNumber < TwilioObject
    def create(url, area_code = nil, method = 'POST', friendly_name = nil)
      Twilio.post("/IncomingPhoneNumbers/Local", :body => {
        :Url => url, 
        :AreaCode => area_code, 
        :Method => method,
        :FriendlyName => friendly_name 
      })
    end
    
    def list
      Twilio.get("/IncomingPhoneNumbers/Local")
    end
  end
end