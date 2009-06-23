require File.dirname(__FILE__) + '/../test_helper'

class LocalPhoneNumberTest < Test::Unit::TestCase #:nodoc: all
  context "A local phone number" do
    setup do
      Twilio.connect('mysid', 'mytoken')
    end

    should "be retrievable as a list" do
      fake_response = fixture(:incoming_phone_numbers)
      FakeWeb.register_uri(:get, twilio_url('IncomingPhoneNumbers/Local'), :string => fake_response)
      assert_equal Twilio::LocalPhoneNumber.list, fake_response
    end
    
    should "be created" do
      fake_response = fixture(:incoming_phone_number)
      FakeWeb.register_uri(:post, twilio_url('IncomingPhoneNumbers/Local'), :string => fake_response)
      assert_equal Twilio::LocalPhoneNumber.create('http://test.local/call_handler'), fake_response
    end
    
    context "using deprecated API" do
      setup do
        @connection = Twilio::Connection.new('mysid', 'mytoken')
        @local = Twilio::LocalPhoneNumber.new(@connection)
      end

      should "be retrievable as a list" do
        fake_response = fixture(:incoming_phone_numbers)
        FakeWeb.register_uri(:get, twilio_url('IncomingPhoneNumbers/Local'), :string => fake_response)
        assert_equal @local.list, fake_response
      end
    end
    
  end
end