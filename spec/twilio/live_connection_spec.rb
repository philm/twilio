require 'spec_helper'

# uncomment and add your own tests here
=begin
describe "testing with a live connection" do
  before(:all) do
    WebMock.allow_net_connect!
    @sid = 'abc123'
    @token = '123'
    Twilio.connect(@sid, @token)
  end

  after(:all) do
    WebMock.disable_net_connect!
  end

  it "gets real account" do
    Twilio::Account.get.should include("TwilioResponse")
  end
end
=end