require 'spec_helper'

describe "Outgoing Caller ID" do
  before(:all) do
    Twilio.connect('mysid', 'mytoken')
    @callerid_sid = 'PNe536dfda7c6184afab78d980cb8cdf43'
  end

  it "gets a list of caller id's" do
    response, url = stub_get(:outgoing_caller_ids, 'OutgoingCallerIds')

    Twilio::OutgoingCallerId.list.should eql response
    WebMock.should have_requested(:get, url)
  end

  it "gets a specific caller id" do
    response, url = stub_get(:outgoing_caller_id, "OutgoingCallerIds/#{@callerid_sid}")

    Twilio::OutgoingCallerId.get(@callerid_sid).should eql response
    WebMock.should have_requested(:get, url)
  end

  it "is created" do
    response, url = stub_post(:outgoing_caller_id_new, 'OutgoingCallerIds')

    Twilio::OutgoingCallerId.create('4158675309', 'My Home Phone').should eql response
    WebMock.should have_requested(:post, url)
  end

  it "is deleted" do
    response, url = stub_delete(:outgoing_caller_id, "OutgoingCallerIds/#{@callerid_sid}")

    Twilio::OutgoingCallerId.delete(@callerid_sid).should eql response
    WebMock.should have_requested(:delete, url)
  end

  it "updates name" do
    response, url = stub_put(:outgoing_caller_id, "OutgoingCallerIds/#{@callerid_sid}")

    Twilio::OutgoingCallerId.update_name(@callerid_sid, 'My office line').should eql response
    WebMock.should have_requested(:put, url)
  end
end