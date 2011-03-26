require 'spec_helper'

describe "Conference" do
  before(:all) do
    Twilio.connect('mysid', 'mytoken')
    @conference_sid = 'CF9f2ead1ae43cdabeab102fa30d938378'
    @call_sid = 'CA9ae8e040497c0598481c2031a154919e'
  end
  
  it "gets a list of conferences" do
    response, url = stub_get(:conferences, 'Conferences')
    
    Twilio::Conference.list.should == response
    WebMock.should have_requested(:get, url)
  end
  
  it "gets a specific conference" do
    response, url = stub_get(:conference, "Conferences/#{@conference_sid}")
    
    Twilio::Conference.get(@conference_sid).should == response
    WebMock.should have_requested(:get, url)
  end
  
  it "gets a list of participants" do
    response, url = stub_get(:conference_participants, "Conferences/#{@conference_sid}/Participants")
    
    Twilio::Conference.participants(@conference_sid).should == response
    WebMock.should have_requested(:get, url)
  end

  it "gets a specific participant" do
    response, url = stub_get(:conference_participant, "Conferences/#{@conference_sid}/Participants/#{@call_sid}")
    
    Twilio::Conference.participant(@conference_sid, @call_sid).should == response
    WebMock.should have_requested(:get, url)
  end

  it "can mute a particant" do
    response, url = stub_post(:conference_participant_muted, "Conferences/#{@conference_sid}/Participants/#{@call_sid}", :body => 'Muted=true')
    
    Twilio::Conference.mute_participant(@conference_sid, @call_sid).should == response
    WebMock.should have_requested(:post, url)
  end

  it "can unmute a participant" do
    response, url = stub_post(:conference_participant, "Conferences/#{@conference_sid}/Participants/#{@call_sid}", :body => 'Muted=false')
    
    Twilio::Conference.unmute_participant(@conference_sid, @call_sid).should == response
    WebMock.should have_requested(:post, url)
  end

  it "can be kicked" do
    response, url = stub_delete(:conference_participant, "Conferences/#{@conference_sid}/Participants/#{@call_sid}")
    
    Twilio::Conference.kick_participant(@conference_sid, @call_sid).should == response
    WebMock.should have_requested(:delete, url)
  end
end