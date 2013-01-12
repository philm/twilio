require 'spec_helper'

describe "Notification" do
  before(:all) do
    Twilio.connect('mysid', 'mytoken')
    @notification_sid = 'NO1fb7086ceb85caed2265f17d7bf7981c'
  end

  it "gets a list of notifications" do
    response, url = stub_get(:notifications, 'Notifications')

    Twilio::Notification.list.should eql response
    WebMock.should have_requested(:get, url)
  end

  it "gets a specific notification" do
    response, url = stub_get(:notification, "Notifications/#{@notification_sid}")

    Twilio::Notification.get(@notification_sid).should eql response
    WebMock.should have_requested(:get, url)
  end

  it "is deleted" do
    response, url = stub_delete(:notification, "Notifications/#{@notification_sid}")

    Twilio::Notification.delete(@notification_sid).should eql response
    WebMock.should have_requested(:delete, url)
  end
end