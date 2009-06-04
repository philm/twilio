require File.dirname(__FILE__) + '/../test_helper'

class ConnectionTest < Test::Unit::TestCase
  context "A Twilio connection" do
    setup do
      @connection = Twilio::Connection.new('mysid', 'mytoken')
    end
    
    context "when initializing" do
      should "have correct url" do
        assert_equal "#{Twilio::Connection::TWILIO_URL}/mysid", @connection.class.base_uri
      end
    end
  end
end