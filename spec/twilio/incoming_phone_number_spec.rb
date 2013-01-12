require 'spec_helper'

describe "Incoming Phone Number" do
  before(:all) do
    Twilio.connect('mysid', 'mytoken')
    @incoming_sid = 'PNe536dfda7c6184afab78d980cb8cdf43'
  end

  it "gets a specific phone number" do
    response, url = stub_get(:incoming_phone_number, "IncomingPhoneNumbers/#{@incoming_sid}")

    Twilio::IncomingPhoneNumber.get(@incoming_sid).should eql response
    WebMock.should have_requested(:get, url)
  end

  it "gets a list of phone numbers" do
    response, url = stub_get(:incoming_phone_numbers, 'IncomingPhoneNumbers')

    Twilio::IncomingPhoneNumber.list.should eql response
    WebMock.should have_requested(:get, url)
  end

  context "creating" do
    it "is created" do
      response, url = stub_post(:incoming_phone_number, 'IncomingPhoneNumbers')

      Twilio::IncomingPhoneNumber.create(:PhoneNumber => '8055551212').should eql response
      WebMock.should have_requested(:post, url)
    end

    it "raises an exception if PhoneNumber or AreaCode are not set" do
      expect { Twilio::IncomingPhoneNumber.create(:FriendlyName => 'Booyah') }.to raise_exception
    end
  end

  it "is deleted" do
    response, url = stub_delete(:incoming_phone_number, "IncomingPhoneNumbers/#{@incoming_sid}")

    Twilio::IncomingPhoneNumber.delete(@incoming_sid).should eql response
    WebMock.should have_requested(:delete, url)
  end
end