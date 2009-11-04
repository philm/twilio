require File.dirname(__FILE__) + '/../test_helper'

class RecordingTest < Test::Unit::TestCase #:nodoc: all
  context "A recording" do
    setup do
      Twilio.connect('mysid', 'mytoken')
    end

    should "be retrievable as a list" do
      assert_equal stub_response(:get, :recordings, :resource => 'Recordings'), Twilio::Recording.list
    end
    
    should "be retrievable individually" do
      assert_equal stub_response(:get, :recording, :resource => 'Recordings/RE41331862605f3d662488fdafda2e175f'),
        Twilio::Recording.get('RE41331862605f3d662488fdafda2e175f')
    end
    
    should "be deleted" do
      stub_response(:delete, :recording, :resource => 'Recordings/RE41331862605f3d662488fdafda2e175f',
                                         :status   => [ 204, "HTTPNoContent" ])
      assert Twilio::Recording.delete('RE41331862605f3d662488fdafda2e175f')
    end
    
    context "with transcriptions" do
      should "be retrievable as a list" do
        assert_equal stub_response(:get, :transcriptions, :resource => 'Recordings/RE41331862605f3d662488fdafda2e175f/Transcriptions'),
          Twilio::Recording.transcriptions('RE41331862605f3d662488fdafda2e175f')
      end

      should "be retrievable individually" do
        assert_equal stub_response(:get, :transcription, :resource => 'Recordings/RE41331862605f3d662488fdafda2e175f/Transcriptions/TRbdece5b75f2cd8f6ef38e0a10f5c4447'),
          Twilio::Recording.transcriptions('RE41331862605f3d662488fdafda2e175f', 'TRbdece5b75f2cd8f6ef38e0a10f5c4447')
      end
    end
  
    context "using deprecated API" do
      setup do
        @connection = Twilio::Connection.new('mysid', 'mytoken')
        @recording = Twilio::Recording.new(@connection)
      end

      should "be retrievable as a list" do
        assert_equal stub_response(:get, :recordings, :resource => 'Recordings'), @recording.list
      end
    end
  end
end