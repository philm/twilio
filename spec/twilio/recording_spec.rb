require 'spec_helper'

describe "Recording" do
  before(:all) do
    Twilio.connect('mysid', 'mytoken')
    @recording_sid = 'RE41331862605f3d662488fdafda2e175f'
    @transcription_sid = 'TRbdece5b75f2cd8f6ef38e0a10f5c4447'
  end
  
  it "gets a list of recordings" do
    response, url = stub_get(:recordings, 'Recordings')
    
    Twilio::Recording.list.should == response
    WebMock.should have_requested(:get, url)
  end
    
  it "gets a specific recording" do
    response, url = stub_get(:recording, "Recordings/#{@recording_sid}")
    
    Twilio::Recording.get(@recording_sid).should == response
    WebMock.should have_requested(:get, url)
  end
  
  it "is deleted" do
    response, url = stub_delete(:recording, "Recordings/#{@recording_sid}")
    
    Twilio::Recording.delete(@recording_sid).should == response
    WebMock.should have_requested(:delete, url)
  end
  
  it "gets a list of transcriptions" do
    response, url = stub_get(:transcriptions, "Recordings/#{@recording_sid}/Transcriptions")
    
    Twilio::Recording.transcriptions(@recording_sid).should == response
    WebMock.should have_requested(:get, url)
  end

  it "gets a specific transcription" do
    response, url = stub_get(:transcriptions, "Recordings/#{@recording_sid}/Transcriptions/#{@transcription_sid}")
    
    Twilio::Recording.transcriptions(@recording_sid, @transcription_sid).should == response
    WebMock.should have_requested(:get, url)
  end
end