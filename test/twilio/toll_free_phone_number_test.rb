require File.dirname(__FILE__) + '/../test_helper'

class TollFreePhoneNumberTest < Test::Unit::TestCase
  context "A toll free phone number" do
    setup do
      @connection = Twilio::Connection.new('mysid', 'mytoken')
      @toll_free = Twilio::TollFreePhoneNumber.new(@connection)
    end

    should "be retrievable as a list" do
      fake_response = fixture(:incoming_phone_numbers)
      FakeWeb.register_uri(:get, twilio_url('IncomingPhoneNumbers/TollFree'), :string => fake_response)
      assert_equal @toll_free.list, fake_response
    end
    
    should "be created" do
      fake_response = fixture(:incoming_phone_number)
      FakeWeb.register_uri(:post, twilio_url('IncomingPhoneNumbers/TollFree'), :string => fake_response)
      response = @toll_free.create('http://test.local/call_handler')
      assert_equal response, fake_response
    end
  end
end