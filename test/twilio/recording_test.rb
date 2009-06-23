require File.dirname(__FILE__) + '/../test_helper'

class RecordingTest < Test::Unit::TestCase #:nodoc: all
  context "A recording" do
    setup do
      Twilio.connect('mysid', 'mytoken')
    end

    should "be retrievable as a list" do
      fake_response = fixture(:recordings)
      FakeWeb.register_uri(:get, twilio_url('Recordings'), :string => fake_response)
      assert_equal Twilio::Recording.list, fake_response
    end
    
    should "be retrievable individually" do
      fake_response = fixture(:recording)
      FakeWeb.register_uri(:get, twilio_url('Recordings/RE41331862605f3d662488fdafda2e175f'), :string => fake_response)
      assert_equal Twilio::Recording.get('RE41331862605f3d662488fdafda2e175f'), fake_response
    end
    
    should "be deleted" do
      FakeWeb.register_uri(:delete, twilio_url('Recordings/RE41331862605f3d662488fdafda2e175f'), :status => [ 204, "HTTPNoContent" ])
      assert Twilio::Recording.delete('RE41331862605f3d662488fdafda2e175f')
    end
    
    context "with transcriptions" do
      should "be retrievable as a list" do
        fake_response = fixture(:transcriptions)
        FakeWeb.register_uri(:get, twilio_url('Recordings/RE41331862605f3d662488fdafda2e175f/Transcriptions'), :string => fake_response)
        assert_equal Twilio::Recording.transcriptions('RE41331862605f3d662488fdafda2e175f'), fake_response
      end

      should "be retrievable individually" do
        fake_response = fixture(:transcription)
        FakeWeb.register_uri(:get, twilio_url('Recordings/RE41331862605f3d662488fdafda2e175f/Transcriptions/TRbdece5b75f2cd8f6ef38e0a10f5c4447'), :string => fake_response)
        assert_equal Twilio::Recording.transcriptions('RE41331862605f3d662488fdafda2e175f', 'TRbdece5b75f2cd8f6ef38e0a10f5c4447'), fake_response
      end
    end
  
    context "using deprecated API" do
      setup do
        @connection = Twilio::Connection.new('mysid', 'mytoken')
        @recording = Twilio::Recording.new(@connection)
      end

      should "be retrievable as a list" do
        fake_response = fixture(:recordings)
        FakeWeb.register_uri(:get, twilio_url('Recordings'), :string => fake_response)
        assert_equal @recording.list, fake_response
      end
    end
  end
end