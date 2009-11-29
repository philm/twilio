require File.dirname(__FILE__) + '/../test_helper'

class CallTest < Test::Unit::TestCase #:nodoc: all
  context "A call" do
    setup do
      Twilio.connect('mysid', 'mytoken')
    end

    should "be retrievable as a list" do
      assert_equal stub_response(:get, :calls, :resource => 'Calls'), Twilio::Call.list
    end
    
    should "be retrievable individually" do
      assert_equal stub_response(:get, :call, :resource => 'Calls/CA42ed11f93dc08b952027ffbc406d0868'), 
        Twilio::Call.get('CA42ed11f93dc08b952027ffbc406d0868')
    end
    
    should "be made" do
      assert_equal stub_response(:post, :call_new, :resource => 'Calls'),
        Twilio::Call.make('4158675309', '4155551212', 'http://test.local/call_handler')
    end
    
    should "be redirected" do
      assert_equal stub_response(:post, :call_redirected, :resource => 'Calls/CA42ed11f93dc08b952027ffbc406d0868'),
        Twilio::Call.redirect('CA42ed11f93dc08b952027ffbc406d0868', 'http://www.myapp.com/myhandler.php')
    end
    
    context "with segments" do
      should "returns a list of Call resources that were segments created in the same call" do
        assert_equal stub_response(:get, :calls, :resource => 'Calls/CA42ed11f93dc08b952027ffbc406d0868/Segments'),
          Twilio::Call.segments('CA42ed11f93dc08b952027ffbc406d0868')
      end
      
      should "returns a single Call resource for the CallSid and CallSegmentSid provided" do
        assert_equal stub_response(:get, :calls, :resource => 'Calls/CA42ed11f93dc08b952027ffbc406d0868/Segments/abc123'),
          Twilio::Call.segments('CA42ed11f93dc08b952027ffbc406d0868', 'abc123')
      end
    end
    
    context "with recordings" do
      should "returns a list of recordings that were generated during the call" do
        assert_equal stub_response(:get, :recordings, :resource => 'Calls/CA42ed11f93dc08b952027ffbc406d0868/Recordings'),
          Twilio::Call.recordings('CA42ed11f93dc08b952027ffbc406d0868')
      end
    end
    
    context "with notifications" do
      should "description" do
        assert_equal stub_response(:get, :notifications, :resource => 'Calls/CA42ed11f93dc08b952027ffbc406d0868/Notifications'),
          Twilio::Call.notifications('CA42ed11f93dc08b952027ffbc406d0868')
      end
    end
    
    context "using deprecated API" do
      setup do
        @connection = Twilio::Connection.new('mysid', 'mytoken')
        @call = Twilio::Call.new(@connection)
      end

      should "be made" do
        assert_equal stub_response(:post, :call_new, :resource => 'Calls'),
          @call.make('4158675309', '4155551212', 'http://test.local/call_handler')
      end
    end
  end
end