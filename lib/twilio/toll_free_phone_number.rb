module Twilio
  # This sub-resource represents only Toll Free phone numbers, or in other words, not local numbers. 
  # Also allows you to request a new toll free phone number be added to your account. 
  class TollFreePhoneNumber < TwilioObject
    def create(url, area_code = nil, method = 'POST', friendly_name = nil)
      self.connection.class.post("/IncomingPhoneNumbers/TollFree", :body => {
        :Url => url, 
        :AreaCode => area_code, 
        :Method => method,
        :FriendlyName => friendly_name 
      })
    end
    
    def list
      self.connection.class.get("/IncomingPhoneNumbers/TollFree")
    end
  end
end