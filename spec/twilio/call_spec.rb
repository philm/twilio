require 'spec_helper'

describe "Call" do
  before(:all) do
    Twilio.connect('mysid', 'mytoken')
    @call_sid = 'CA42ed11f93dc08b952027ffbc406d0868'
  end

  it "can be made" do
    response, url = stub_post(:call_new, 'Calls')

    Twilio::Call.make('4158675309', '4155551212', 'http://localhost:3000/call_handler').should eql response
    WebMock.should have_requested(:post, url)
  end

  it "can be redirected" do
    response, url = stub_post(:call_redirected, "Calls/#{@call_sid}")

    Twilio::Call.redirect(@call_sid, 'http://localhost:3000/redirect_handler').should eql response
    WebMock.should have_requested(:post, url)
  end

  it "gets a list of calls" do
    response, url = stub_get(:calls, 'Calls')

    Twilio::Call.list.should eql response
    WebMock.should have_requested(:get, url)
  end

  it "gets a specific call" do
    response, url = stub_get(:calls, "Calls/#{@call_sid}")

    Twilio::Call.get(@call_sid).should eql response
    WebMock.should have_requested(:get, url)
  end

  it "gets a list of call segments" do
    response, url = stub_get(:calls, "Calls/#{@call_sid}/Segments")

    Twilio::Call.segments(@call_sid).should eql response
    WebMock.should have_requested(:get, url)
  end

  it "gets a specific call segment" do
    response, url = stub_get(:calls, "Calls/#{@call_sid}/Segments/abc123")

    Twilio::Call.segments(@call_sid, 'abc123').should eql response
    WebMock.should have_requested(:get, url)
  end

  it "gets a list of call recordings" do
    response, url = stub_get(:recordings, "Calls/#{@call_sid}/Recordings")

    Twilio::Call.recordings(@call_sid).should eql response
    WebMock.should have_requested(:get, url)
  end

  it "gets a list of call notifications" do
    response, url = stub_get(:notifications, "Calls/#{@call_sid}/Notifications")

    Twilio::Call.notifications(@call_sid).should eql response
    WebMock.should have_requested(:get, url)
  end
end