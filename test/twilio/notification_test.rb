require 'test_helper'

class NotificationTest < Test::Unit::TestCase #:nodoc: all
  context "A recording" do
    setup do
      Twilio.connect('mysid', 'mytoken')
    end

    should "be retrievable as a list" do
      assert_equal stub_response(:get, :notifications, :resource => 'Notifications'), Twilio::Notification.list
    end
    
    should "be retrievable individually" do
      assert_equal stub_response(:get, :notification, :resource => 'Notifications/NO1fb7086ceb85caed2265f17d7bf7981c'), 
        Twilio::Notification.get('NO1fb7086ceb85caed2265f17d7bf7981c')
    end
    
    should "be deleted" do
      stub_response(:delete, :notification, { :resource => 'Notifications/NO1fb7086ceb85caed2265f17d7bf7981c', 
                                              :status   => [ 204, "HTTPNoContent" ] })
      assert Twilio::Notification.delete('NO1fb7086ceb85caed2265f17d7bf7981c')
    end
    
    context "using deprecated API" do
      setup do
        @connection = Twilio::Connection.new('mysid', 'mytoken')
        @notification = Twilio::Notification.new(@connection)
      end

      should "be retrievable as a list" do
        assert_equal stub_response(:get, :notifications, :resource => 'Notifications'), @notification.list
      end
    end
  end
end