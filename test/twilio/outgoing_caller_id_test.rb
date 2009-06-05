require File.dirname(__FILE__) + '/../test_helper'

class OutgoingCallerIdTest < Test::Unit::TestCase #:nodoc: all
  context "An outgoing caller id" do
    setup do
      @connection = Twilio::Connection.new('mysid', 'mytoken')
      @caller_id = Twilio::OutgoingCallerId.new(@connection)
    end

    should "be retrievable as a list" do
      fake_response = fixture(:outgoing_caller_ids)
      FakeWeb.register_uri(:get, twilio_url('OutgoingCallerIds'), :string => fake_response)
      assert_equal @caller_id.list, fake_response
    end
    
    should "be retrievable individually" do
      fake_response = fixture(:outgoing_caller_id)
      FakeWeb.register_uri(:get, twilio_url('OutgoingCallerIds/PNe536dfda7c6184afab78d980cb8cdf43'), :string => fake_response)
      assert_equal @caller_id.get('PNe536dfda7c6184afab78d980cb8cdf43'), fake_response
    end
    
    should "be created" do
      fake_response = fixture(:outgoing_caller_id_new)
      FakeWeb.register_uri(:post, twilio_url('OutgoingCallerIds'), :string => fake_response)
      response = @caller_id.create('4158675309', 'My Home Phone')
      assert_equal response, fake_response
    end
    
    should "be able to update name" do
      fake_response = fixture(:outgoing_caller_id)
      FakeWeb.register_uri(:put, twilio_url('OutgoingCallerIds/PNe536dfda7c6184afab78d980cb8cdf43'), :string => fake_response)
      response = @caller_id.update_name('PNe536dfda7c6184afab78d980cb8cdf43', 'My office line')
      assert_equal response, fake_response
    end
    
    should "be deleted" do
      FakeWeb.register_uri(:delete, twilio_url('OutgoingCallerIds/PNe536dfda7c6184afab78d980cb8cdf43'), :status => [ 204, "HTTPNoContent" ])
      response = @caller_id.delete('PNe536dfda7c6184afab78d980cb8cdf43')
      assert response
    end
  end
end