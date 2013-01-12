require 'spec_helper'

describe 'Account' do
  before(:all) do
    Twilio.connect('mysid', 'mytoken')
  end

  it "gets an account" do
    response, url = stub_get(:account)

    Twilio::Account.get.should eql response
    WebMock.should have_requested(:get, twilio_url)
  end

  it "updates name" do
    response, url = stub_put(:account_renamed)

    Twilio::Account.update_name('Bubba').should eql response
    WebMock.should have_requested(:put, twilio_url).with(:body => {:FriendlyName => 'Bubba'})
  end
end