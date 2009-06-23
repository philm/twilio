require File.dirname(__FILE__) + '/../test_helper'

class NotificationTest < Test::Unit::TestCase #:nodoc: all
  context "A recording" do
    setup do
      Twilio.connect('mysid', 'mytoken')
    end

    should "be retrievable as a list" do
      fake_response = fixture(:notifications)
      FakeWeb.register_uri(:get, twilio_url('Notifications'), :string => fake_response)
      assert_equal Twilio::Notification.list, fake_response
    end
    
    should "be retrievable individually" do
      fake_response = fixture(:notification)
      FakeWeb.register_uri(:get, twilio_url('Notifications/NO1fb7086ceb85caed2265f17d7bf7981c'), :string => fake_response)
      assert_equal Twilio::Notification.get('NO1fb7086ceb85caed2265f17d7bf7981c'), fake_response
    end
    
    should "be deleted" do
      FakeWeb.register_uri(:delete, twilio_url('Notifications/NO1fb7086ceb85caed2265f17d7bf7981c'), :status => [ 204, "HTTPNoContent" ])
      assert Twilio::Notification.delete('NO1fb7086ceb85caed2265f17d7bf7981c')
    end
    
    context "using deprecated API" do
      setup do
        @connection = Twilio::Connection.new('mysid', 'mytoken')
        @notification = Twilio::Notification.new(@connection)
      end

      should "be retrievable as a list" do
        fake_response = fixture(:notifications)
        FakeWeb.register_uri(:get, twilio_url('Notifications'), :string => fake_response)
        assert_equal @notification.list, fake_response
      end
    end
    
  end
end