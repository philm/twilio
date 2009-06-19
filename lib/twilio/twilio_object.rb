module Twilio
  class TwilioObject  #:nodoc: all
    include HTTParty
    
    attr_reader :connection
    
    def initialize(connection)
      @connection = connection
    end
  end
end