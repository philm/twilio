module Twilio
  # This sub-resource represents only Local phone numbers, or in other words, not toll-free numbers. 
  # Also allows you to request a new local phone number be added to your account. 
  class LocalPhoneNumber < TwilioObject
    def create(url, area_code = nil, method = 'POST', friendly_name = nil)
      self.connection.class.post("/IncomingPhoneNumbers/Local", :body => {
        :Url => url, 
        :AreaCode => area_code, 
        :Method => method,
        :FriendlyName => friendly_name 
      })
    end
    
    def list
      self.connection.class.get("/IncomingPhoneNumbers/Local")
    end
  end
end