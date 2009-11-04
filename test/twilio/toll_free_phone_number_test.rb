require File.dirname(__FILE__) + '/../test_helper'

class TollFreePhoneNumberTest < Test::Unit::TestCase #:nodoc: all
  context "A toll free phone number" do
    setup do
      Twilio.connect('mysid', 'mytoken')
    end

    should "be retrievable as a list" do
      assert_equal stub_response(:get, :incoming_phone_numbers, :resource => 'IncomingPhoneNumbers/TollFree'),
        Twilio::TollFreePhoneNumber.list
    end
    
    should "be created" do
      assert_equal stub_response(:post, :incoming_phone_number, :resource => 'IncomingPhoneNumbers/TollFree'),
        Twilio::TollFreePhoneNumber.create('http://test.local/call_handler')
    end
    
    context "using deprecated API" do
      setup do
        @connection = Twilio::Connection.new('mysid', 'mytoken')
        @toll_free = Twilio::TollFreePhoneNumber.new(@connection)
      end

      should "be retrievable as a list" do
        assert_equal stub_response(:get, :incoming_phone_numbers, :resource => 'IncomingPhoneNumbers/TollFree'),
          @toll_free.list
      end
    end
  end
end