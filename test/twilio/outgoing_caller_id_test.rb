require 'test_helper'

class OutgoingCallerIdTest < Test::Unit::TestCase #:nodoc: all
  context "An outgoing caller id" do
    setup do
      Twilio.connect('mysid', 'mytoken')
    end

    should "be retrievable as a list" do
      assert_equal stub_response(:get, :outgoing_caller_ids, :resource => 'OutgoingCallerIds'), Twilio::OutgoingCallerId.list
    end
    
    should "be retrievable individually" do
      assert_equal stub_response(:get, :outgoing_caller_id, :resource => 'OutgoingCallerIds/PNe536dfda7c6184afab78d980cb8cdf43'),
        Twilio::OutgoingCallerId.get('PNe536dfda7c6184afab78d980cb8cdf43')
    end
    
    should "be created" do
      assert_equal stub_response(:post, :outgoing_caller_id_new, :resource => 'OutgoingCallerIds'),
        Twilio::OutgoingCallerId.create('4158675309', 'My Home Phone')
    end
    
    should "be able to update name" do
      assert_equal stub_response(:put, :outgoing_caller_id, :resource => 'OutgoingCallerIds/PNe536dfda7c6184afab78d980cb8cdf43'),
        Twilio::OutgoingCallerId.update_name('PNe536dfda7c6184afab78d980cb8cdf43', 'My office line')
    end
    
    should "be deleted" do
      stub_response(:delete, :outgoing_caller_id, :resource => 'OutgoingCallerIds/PNe536dfda7c6184afab78d980cb8cdf43', 
                                                  :status   => [ 204, "HTTPNoContent" ])
      assert Twilio::OutgoingCallerId.delete('PNe536dfda7c6184afab78d980cb8cdf43')
    end
    
    context "using deprecated API" do
      setup do
        @connection = Twilio::Connection.new('mysid', 'mytoken')
        @caller_id = Twilio::OutgoingCallerId.new(@connection)
      end

      should "be retrievable as a list" do
        assert_equal stub_response(:get, :outgoing_caller_ids, :resource => 'OutgoingCallerIds'), @caller_id.list
      end
    end
  end
end