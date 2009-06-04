module Twilio
  class TwilioObject
    include HTTParty
    
    attr_reader :connection
    
    def initialize(connection)
      @connection = connection
    end
  end
end