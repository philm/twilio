require File.dirname(__FILE__) + '/../test_helper'

class VerbTest < Test::Unit::TestCase #:nodoc: all
  context "A Twilio Verb" do
    should "say 'hi'" do
      assert_equal verb_response(:say_hi), Twilio::Verb.say('hi')
    end

    should "say 'hi' with female voice" do
      assert_equal verb_response(:say_hi_with_female_voice), Twilio::Verb.say('hi', :voice => 'woman')
    end
        
    should "say 'hola' in Spanish with female voice" do
      assert_equal verb_response(:say_hi_in_spanish_with_female_voice), Twilio::Verb.say('hola', {:voice => 'woman', :language => 'es'})
    end
    
    should "say 'hi' three times" do
      assert_equal verb_response(:say_hi_three_times), Twilio::Verb.say_3_times('hi')
    end
    
    should "say 'hi' three times with pause" do
      assert_equal verb_response(:say_hi_three_times_with_pause), Twilio::Verb.say_3_times_with_pause('hi')
    end
    
    should "play mp3 response" do
      assert_equal verb_response(:play_mp3), Twilio::Verb.play('http://foo.com/cowbell.mp3')
    end
    
    should "play mp3 response two times" do
      assert_equal verb_response(:play_mp3_two_times), Twilio::Verb.play_2_times('http://foo.com/cowbell.mp3')
    end
   
    should "play mp3 response two times with pause" do
      assert_equal verb_response(:play_mp3_two_times_with_pause), Twilio::Verb.play_2_times_with_pause('http://foo.com/cowbell.mp3')
    end
     
    should "gather" do
      assert_equal verb_response(:gather), Twilio::Verb.gather
    end
    
    should "gather with action" do
      assert_equal verb_response(:gather_with_action), Twilio::Verb.gather(:action => 'http://foobar.com')
    end
    
    should "gather with GET method" do
      assert_equal verb_response(:gather_with_get_method), Twilio::Verb.gather(:method => 'GET')
    end
    
    should "gather with timeout" do
      assert_equal verb_response(:gather_with_timeout), Twilio::Verb.gather(:timeout => 10)
    end
    
    should "gather with finish key" do
      assert_equal verb_response(:gather_with_finish_key), Twilio::Verb.gather(:finishOnKey => '*')
    end
    
    should "gather with num digits" do
      assert_equal verb_response(:gather_with_num_digits), Twilio::Verb.gather(:numDigits => 5)
    end
    
    should "gather with all options set" do
      assert_equal verb_response(:gather_with_all_options_set), Twilio::Verb.gather(:action => 'http://foobar.com', :method => 'GET', :timeout => 10, :finishOnKey => '*', :numDigits => 5)
    end
    
    should "record" do
      assert_equal verb_response(:record), Twilio::Verb.record
    end
    
    should "record with action" do
      assert_equal verb_response(:record_with_action), Twilio::Verb.record(:action => 'http://foobar.com')
    end
    
    should "record with GET method" do
      assert_equal verb_response(:record_with_get_method), Twilio::Verb.record(:method => 'GET')
    end
    
    should "record with timeout" do
      assert_equal verb_response(:record_with_timeout), Twilio::Verb.record(:timeout => 10)
    end
    
    should "record with finish key" do
      assert_equal verb_response(:record_with_finish_key), Twilio::Verb.record(:finishOnKey => '*')
    end
    
    should "record with max length" do
      assert_equal verb_response(:record_with_max_length), Twilio::Verb.record(:maxLength => 1800)      
    end
    
    should "record with transcribe" do
      assert_equal verb_response(:record_with_transcribe), Twilio::Verb.record(:transcribe => true, :transcribeCallback => '/handle_transcribe')            
    end
    
    should "dial" do
      assert_equal verb_response(:dial), Twilio::Verb.dial('415-123-4567')
    end
    
    should "dial with action" do
      assert_equal verb_response(:dial_with_action), Twilio::Verb.dial('415-123-4567', :action => 'http://foobar.com')
    end
    
    should "dial with GET method" do
      assert_equal verb_response(:dial_with_get_method), Twilio::Verb.dial('415-123-4567', :method => 'GET')
    end
    
    should "dial with timeout" do
      assert_equal verb_response(:dial_with_timeout), Twilio::Verb.dial('415-123-4567', :timeout => 10)
    end
    
    should "dial with hangup on star" do
      assert_equal verb_response(:dial_with_hangup_on_star), Twilio::Verb.dial('415-123-4567', :hangupOnStar => true)
    end
    
    should "dial with time limit" do
      assert_equal verb_response(:dial_with_time_limit), Twilio::Verb.dial('415-123-4567', :timeLimit => 3600)
    end
    
    should "dial with caller id" do
      assert_equal verb_response(:dial_with_caller_id), Twilio::Verb.dial('415-123-4567', :callerId => '858-987-6543')
    end
    
    should "dial with timeout and caller id" do
      assert_equal verb_response(:dial_with_timeout_and_caller_id), Twilio::Verb.dial('415-123-4567', {:timeout => 10, :callerId => '858-987-6543'})
    end
  end
  
end