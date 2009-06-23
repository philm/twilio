require File.dirname(__FILE__) + '/../test_helper'

class OutgoingCallerIdTest < Test::Unit::TestCase #:nodoc: all
  context "An outgoing caller id" do
    setup do
      Twilio.connect('mysid', 'mytoken')
    end

    should "be retrievable as a list" do
      fake_response = fixture(:outgoing_caller_ids)
      FakeWeb.register_uri(:get, twilio_url('OutgoingCallerIds'), :string => fake_response)
      assert_equal Twilio::OutgoingCallerId.list, fake_response
    end
    
    should "be retrievable individually" do
      fake_response = fixture(:outgoing_caller_id)
      FakeWeb.register_uri(:get, twilio_url('OutgoingCallerIds/PNe536dfda7c6184afab78d980cb8cdf43'), :string => fake_response)
      assert_equal Twilio::OutgoingCallerId.get('PNe536dfda7c6184afab78d980cb8cdf43'), fake_response
    end
    
    should "be created" do
      fake_response = fixture(:outgoing_caller_id_new)
      FakeWeb.register_uri(:post, twilio_url('OutgoingCallerIds'), :string => fake_response)
      assert_equal Twilio::OutgoingCallerId.create('4158675309', 'My Home Phone'), fake_response
    end
    
    should "be able to update name" do
      fake_response = fixture(:outgoing_caller_id)
      FakeWeb.register_uri(:put, twilio_url('OutgoingCallerIds/PNe536dfda7c6184afab78d980cb8cdf43'), :string => fake_response)
      assert_equal Twilio::OutgoingCallerId.update_name('PNe536dfda7c6184afab78d980cb8cdf43', 'My office line'), fake_response
    end
    
    should "be deleted" do
      FakeWeb.register_uri(:delete, twilio_url('OutgoingCallerIds/PNe536dfda7c6184afab78d980cb8cdf43'), :status => [ 204, "HTTPNoContent" ])
      assert Twilio::OutgoingCallerId.delete('PNe536dfda7c6184afab78d980cb8cdf43')
    end
    
    context "using deprecated API" do
      setup do
        @connection = Twilio::Connection.new('mysid', 'mytoken')
        @caller_id = Twilio::OutgoingCallerId.new(@connection)
      end

      should "be retrievable as a list" do
        fake_response = fixture(:outgoing_caller_ids)
        FakeWeb.register_uri(:get, twilio_url('OutgoingCallerIds'), :string => fake_response)
        assert_equal @caller_id.list, fake_response
      end
    end
  end
end