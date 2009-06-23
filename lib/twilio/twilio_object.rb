module Twilio
  class TwilioObject  #:nodoc: all    
    attr_reader :connection
    
    def initialize(connection = nil)
      @connection = connection
    end
    
    class << self
      def method_missing(method_id, *args) #:nodoc:
        o = self.new
        o.send(method_id, *args)
      end
    end
  end
end