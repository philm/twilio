module Twilio
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