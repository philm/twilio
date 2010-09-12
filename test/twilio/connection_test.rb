require 'test_helper'

class ConnectionTest < Test::Unit::TestCase #:nodoc: all
  context "A Twilio connection" do
    setup do
      @connection = Twilio::Connection.new('mysid', 'mytoken')
    end
    
    context "when initializing" do
      should "have correct url" do
        assert_equal "#{Twilio::Connection::TWILIO_URL}/mysid", @connection.class.base_uri
      end
    end
    
    context "when invoked as class method" do
      setup do
        Twilio.connect('mysid', 'mytoken')
      end
      
      should "have correct url" do
        assert_equal "#{Twilio::TWILIO_URL}/mysid", Twilio.base_uri
      end
    end
  end
end