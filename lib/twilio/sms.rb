module Twilio
    # An SMS message resource represents an Inbound or Outbound SMS message. When someone sends a text message from
    # or to your application, either via the REST API, or during a call via the verb, an SMS message resource is created.
  class Sms < TwilioObject
    #  Example:
    #  Twilio.connect('my_twilio_sid', 'my_auth_token')
    #  Twilio::Sms.message(CALLER_ID, user_number, 'This is my simple SMS message')
    def message(from, to, body)
      Twilio.post("/SMS/Messages", :body => {:From => from, :To => to, :Body => body})
    end

    def list(optional = {})
      Twilio.get("/SMS/Messages", :query => optional)
    end

    def get(sms_message_sid)
      Twilio.get("/SMS/Messages/#{sms_message_sid}")
    end

  end
end