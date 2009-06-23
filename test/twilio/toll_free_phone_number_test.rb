require File.dirname(__FILE__) + '/../test_helper'

class TollFreePhoneNumberTest < Test::Unit::TestCase #:nodoc: all
  context "A toll free phone number" do
    setup do
      Twilio.connect('mysid', 'mytoken')
    end

    should "be retrievable as a list" do
      fake_response = fixture(:incoming_phone_numbers)
      FakeWeb.register_uri(:get, twilio_url('IncomingPhoneNumbers/TollFree'), :string => fake_response)
      assert_equal Twilio::TollFreePhoneNumber.list, fake_response
    end
    
    should "be created" do
      fake_response = fixture(:incoming_phone_number)
      FakeWeb.register_uri(:post, twilio_url('IncomingPhoneNumbers/TollFree'), :string => fake_response)
      assert_equal Twilio::TollFreePhoneNumber.create('http://test.local/call_handler'), fake_response
    end
    
    context "using deprecated API" do
      setup do
        @connection = Twilio::Connection.new('mysid', 'mytoken')
        @toll_free = Twilio::TollFreePhoneNumber.new(@connection)
      end

      should "be retrievable as a list" do
        fake_response = fixture(:incoming_phone_numbers)
        FakeWeb.register_uri(:get, twilio_url('IncomingPhoneNumbers/TollFree'), :string => fake_response)
        assert_equal @toll_free.list, fake_response
      end
    end
    
  end
end