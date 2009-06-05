require File.dirname(__FILE__) + '/../test_helper'

class IncomingPhoneNumberTest < Test::Unit::TestCase #:nodoc: all
  context "An incoming phone number" do
    setup do
      @connection = Twilio::Connection.new('mysid', 'mytoken')
      @incoming = Twilio::IncomingPhoneNumber.new(@connection)
    end

    should "be retrievable as a list" do
      fake_response = fixture(:incoming_phone_numbers)
      FakeWeb.register_uri(:get, twilio_url('IncomingPhoneNumbers'), :string => fake_response)
      assert_equal @incoming.list, fake_response
    end
    
    should "be retrievable individually" do
      fake_response = fixture(:incoming_phone_number)
      FakeWeb.register_uri(:get, twilio_url('IncomingPhoneNumbers/PNe536dfda7c6184afab78d980cb8cdf43'), :string => fake_response)
      assert_equal @incoming.get('PNe536dfda7c6184afab78d980cb8cdf43'), fake_response
    end
  end
end