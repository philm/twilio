require 'test_helper'

class ConferenceTest < Test::Unit::TestCase #:nodoc: all
  context "A conference" do
    setup do
      Twilio.connect('mysid', 'mytoken')
    end
    
    should "be retrievable as a list" do
      assert_equal stub_response(:get, :conferences, :resource => 'Conferences'), Twilio::Conference.list
    end
    
    should "be retrievable individually" do
      assert_equal stub_response(:get, :conference, :resource => 'Conferences/CFd0a50bbe038c437e87f6c82db8f37f21'), 
        Twilio::Conference.get('CFd0a50bbe038c437e87f6c82db8f37f21')
    end
    
    context "participant" do
      should "be retrievable as a list" do
        assert_equal stub_response(:get, :conference_participants, :resource => 'Conferences/CF9f2ead1ae43cdabeab102fa30d938378/Participants'),
          Twilio::Conference.participants('CF9f2ead1ae43cdabeab102fa30d938378')
      end
      
      should "be retrievable individually" do
          assert_equal stub_response(:get, :conference_participant, :resource => 'Conferences/CF9f2ead1ae43cdabeab102fa30d938378/Participants/CA9ae8e040497c0598481c2031a154919e'),
            Twilio::Conference.participant('CF9f2ead1ae43cdabeab102fa30d938378', 'CA9ae8e040497c0598481c2031a154919e')
      end
      
      should "be muted" do
        assert_equal stub_response(:post, :conference_participant_muted, :resource => 'Conferences/CF9f2ead1ae43cdabeab102fa30d938378/Participants/CA9ae8e040497c0598481c2031a154919e'),
          Twilio::Conference.mute_participant('CF9f2ead1ae43cdabeab102fa30d938378', 'CA9ae8e040497c0598481c2031a154919e')
      end
      
      should "be unmuted" do
        assert_equal stub_response(:post, :conference_participant, :resource => 'Conferences/CF9f2ead1ae43cdabeab102fa30d938378/Participants/CA9ae8e040497c0598481c2031a154919e'),
          Twilio::Conference.unmute_participant('CF9f2ead1ae43cdabeab102fa30d938378', 'CA9ae8e040497c0598481c2031a154919e')
      end
      
      should "be kicked" do
        stub_response(:delete, :conference_participant, :resource => 'Conferences/CF9f2ead1ae43cdabeab102fa30d938378/Participants/CA9ae8e040497c0598481c2031a154919e',
                      :status => [ 204, "HTTPNoContent" ])
        assert Twilio::Conference.kick_participant('CF9f2ead1ae43cdabeab102fa30d938378', 'CA9ae8e040497c0598481c2031a154919e')
      end
    end
  end
end