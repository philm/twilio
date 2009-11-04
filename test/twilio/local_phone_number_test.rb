require File.dirname(__FILE__) + '/../test_helper'

class LocalPhoneNumberTest < Test::Unit::TestCase #:nodoc: all
  context "A local phone number" do
    setup do
      Twilio.connect('mysid', 'mytoken')
    end

    should "be retrievable as a list" do
      assert_equal stub_response(:get, :incoming_phone_numbers, :resource => 'IncomingPhoneNumbers/Local'), 
        Twilio::LocalPhoneNumber.list
    end
    
    should "be created" do
      assert_equal stub_response(:post, :incoming_phone_number, :resource => 'IncomingPhoneNumbers/Local'), 
        Twilio::LocalPhoneNumber.create('http://test.local/call_handler')
    end
    
    context "using deprecated API" do
      setup do
        @connection = Twilio::Connection.new('mysid', 'mytoken')
        @local = Twilio::LocalPhoneNumber.new(@connection)
      end

      should "be retrievable as a list" do
        assert_equal stub_response(:get, :incoming_phone_numbers, :resource => 'IncomingPhoneNumbers/Local'),
          @local.list
      end
    end
  end
end