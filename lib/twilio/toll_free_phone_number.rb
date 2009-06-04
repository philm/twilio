module Twilio
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