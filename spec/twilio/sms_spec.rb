require 'spec_helper'

describe "SMS" do
  before(:all) do
    Twilio.connect('mysid', 'mytoken')
    @sms_sid = 'SM872fb94e3b358913777cdb313f25b46f'
  end
  
  it "gets a list of SMS messages" do
    response, url = stub_get(:sms_messages, 'SMS/Messages')
    
    Twilio::Sms.list.should == response
    WebMock.should have_requested(:get, url)
  end

  it "gets a specific SMS message" do
    response, url = stub_get(:sms, "SMS/Messages/#{@sms_sid}")
    
    Twilio::Sms.get(@sms_sid).should == response
    WebMock.should have_requested(:get, url)
  end
  
  it "is created" do
    response, url = stub_post(:sms_new, "SMS/Messages")
    
    Twilio::Sms.message('4155551212', '5558675309', 'Hi Jenny! Want to grab dinner?').should == response
    WebMock.should have_requested(:post, url)
  end
  
  it "is created with a callback URL" do
    response, url = stub_post(:sms_new_with_callback, "SMS/Messages")
    
    Twilio::Sms.message('4155551212', '5558675309', 'Hi Jenny! Want to grab dinner?', 'http://example.com/callback').should == response
    WebMock.should have_requested(:post, url)
  end
end