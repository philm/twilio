require 'test_helper'

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

    should "be deleted" do
      stub_response(:delete, :incoming_phone_number, { :resource => 'IncomingPhoneNumbers/PNe536dfda7c6184afab78d980cb8cdf43', 
                                              :status   => [ 204, "HTTPNoContent" ] })
      assert Twilio::TollFreePhoneNumber.delete('PNe536dfda7c6184afab78d980cb8cdf43')
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