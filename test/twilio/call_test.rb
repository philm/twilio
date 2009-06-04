require File.dirname(__FILE__) + '/../test_helper'

class CallTest < Test::Unit::TestCase
  context "A call" do
    setup do
      @connection = Twilio::Connection.new('mysid', 'mytoken')
      @call = Twilio::Call.new(@connection)
    end

    should "be retrievable as a list" do
      fake_response = fixture(:calls)
      FakeWeb.register_uri(:get, twilio_url('Calls'), :string => fake_response)
      assert_equal @call.list, fake_response
    end
    
    should "be retrievable individually" do
      fake_response = fixture(:call)
      FakeWeb.register_uri(:get, twilio_url('Calls/CA42ed11f93dc08b952027ffbc406d0868'), :string => fake_response)
      assert_equal @call.get('CA42ed11f93dc08b952027ffbc406d0868'), fake_response
    end
    
    should "be made" do
      fake_response = fixture(:call_new)
      FakeWeb.register_uri(:post, twilio_url('Calls'), :string => fake_response)
      response = @call.make('4158675309', '4155551212', 'http://test.local/call_handler')
      assert_equal response, fake_response
    end
    
    context "with segments" do
      should "returns a list of Call resources that were segments created in the same call" do
        fake_response = fixture(:calls)
        FakeWeb.register_uri(:get, twilio_url('Calls/CA42ed11f93dc08b952027ffbc406d0868/Segments'), :string => fake_response)
        assert_equal @call.segments('CA42ed11f93dc08b952027ffbc406d0868'), fake_response
      end
      
      should "returns a single Call resource for the CallSid and CallSegmentSid provided" do
        fake_response = fixture(:calls)
        FakeWeb.register_uri(:get, twilio_url('Calls/CA42ed11f93dc08b952027ffbc406d0868/Segments/abc123'), :string => fake_response)
        assert_equal @call.segments('CA42ed11f93dc08b952027ffbc406d0868', 'abc123'), fake_response
      end
    end
    
    context "with recordings" do
      should "returns a list of recordings that were generated during the call" do
        fake_response = fixture(:recordings)
        FakeWeb.register_uri(:get, twilio_url('Calls/CA42ed11f93dc08b952027ffbc406d0868/Recordings'), :string => fake_response)
        assert_equal @call.recordings('CA42ed11f93dc08b952027ffbc406d0868'), fake_response
      end
    end
    
    context "with notifications" do
      should "description" do
        fake_response = fixture(:notifications)
        FakeWeb.register_uri(:get, twilio_url('Calls/CA42ed11f93dc08b952027ffbc406d0868/Notifications'), :string => fake_response)
        assert_equal @call.notifications('CA42ed11f93dc08b952027ffbc406d0868'), fake_response
      end
    end
  end
end