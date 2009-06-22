require File.dirname(__FILE__) + '/../test_helper'

class VerbTest < Test::Unit::TestCase #:nodoc: all
  context "A Twilio Verb" do
    should "say 'hi'" do
      assert_equal verb_response(:say_hi), Twilio::Verb.new.say('hi')
    end

    should "say 'hi' with female voice" do
      assert_equal verb_response(:say_hi_with_female_voice), Twilio::Verb.new.say('hi', :voice => 'woman')
    end
        
    should "say 'hola' in Spanish with female voice" do
      assert_equal verb_response(:say_hi_in_spanish_with_female_voice), Twilio::Verb.new.say('hola', {:voice => 'woman', :language => 'es'})
    end
    
    should "say 'hi' three times" do
      assert_equal verb_response(:say_hi_three_times), Twilio::Verb.new.say('hi', :loop => 3)
    end
    
    should "say 'hi' three times with pause" do
      assert_equal verb_response(:say_hi_three_times_with_pause), Twilio::Verb.new.say('hi', :loop => 3, :pause => true)
    end
    
    should "say 'hi' with pause and say 'bye'" do
      verb = Twilio::Verb.new { |v|
        v.say('hi', :loop => 1)
        v.pause
        v.say('bye')
      }
      assert_equal verb_response(:say_hi_with_pause_and_say_bye), verb.response
    end
    
    should "say 'hi' with 2 second pause and say 'bye'" do
      verb = Twilio::Verb.new { |v|
        v.say('hi')
        v.pause(:length => 2)
        v.say('bye')
      }
      assert_equal verb_response(:say_hi_with_2_second_pause_and_say_bye), verb.response
    end
    
    should "play mp3 response" do
      assert_equal verb_response(:play_mp3), Twilio::Verb.new.play('http://foo.com/cowbell.mp3')
    end
    
    should "play mp3 response two times" do
      assert_equal verb_response(:play_mp3_two_times), Twilio::Verb.new.play('http://foo.com/cowbell.mp3', :loop => 2)
    end
   
    should "play mp3 response two times with pause" do
      assert_equal verb_response(:play_mp3_two_times_with_pause), Twilio::Verb.new.play('http://foo.com/cowbell.mp3', :loop => 2, :pause => true)
    end
     
    should "gather" do
      assert_equal verb_response(:gather), Twilio::Verb.new.gather
    end
    
    should "gather with action" do
      assert_equal verb_response(:gather_with_action), Twilio::Verb.new.gather(:action => 'http://foobar.com')
    end
    
    should "gather with GET method" do
      assert_equal verb_response(:gather_with_get_method), Twilio::Verb.new.gather(:method => 'GET')
    end
    
    should "gather with timeout" do
      assert_equal verb_response(:gather_with_timeout), Twilio::Verb.new.gather(:timeout => 10)
    end
    
    should "gather with finish key" do
      assert_equal verb_response(:gather_with_finish_key), Twilio::Verb.new.gather(:finishOnKey => '*')
    end
    
    should "gather with num digits" do
      assert_equal verb_response(:gather_with_num_digits), Twilio::Verb.new.gather(:numDigits => 5)
    end
    
    should "gather with all options set" do
      assert_equal verb_response(:gather_with_all_options_set), Twilio::Verb.new.gather(:action => 'http://foobar.com', :method => 'GET', :timeout => 10, :finishOnKey => '*', :numDigits => 5)
    end
    
    should "gather and say instructions" do
      verb = Twilio::Verb.new { |v|
        v.gather {
          v.say('Please enter your account number followed by the pound sign')
        }
        v.say("We didn't receive any input. Goodbye!")
      }
      assert_equal verb_response(:gather_and_say_instructions), verb.response
    end
    
    should "gather with timeout and say instructions" do
      verb = Twilio::Verb.new { |v|
        v.gather(:timeout => 10) {
          v.say('Please enter your account number followed by the pound sign')
        }
        v.say("We didn't receive any input. Goodbye!")
      }
      assert_equal verb_response(:gather_with_timeout_and_say_instructions), verb.response
    end
    
    should "record" do
      assert_equal verb_response(:record), Twilio::Verb.new.record
    end
    
    should "record with action" do
      assert_equal verb_response(:record_with_action), Twilio::Verb.new.record(:action => 'http://foobar.com')
    end
    
    should "record with GET method" do
      assert_equal verb_response(:record_with_get_method), Twilio::Verb.new.record(:method => 'GET')
    end
    
    should "record with timeout" do
      assert_equal verb_response(:record_with_timeout), Twilio::Verb.new.record(:timeout => 10)
    end
    
    should "record with finish key" do
      assert_equal verb_response(:record_with_finish_key), Twilio::Verb.new.record(:finishOnKey => '*')
    end
    
    should "record with max length" do
      assert_equal verb_response(:record_with_max_length), Twilio::Verb.new.record(:maxLength => 1800)      
    end
    
    should "record with transcribe" do
      assert_equal verb_response(:record_with_transcribe), Twilio::Verb.new.record(:transcribe => true, :transcribeCallback => '/handle_transcribe')            
    end
    
    should "dial" do
      assert_equal verb_response(:dial), Twilio::Verb.new.dial('415-123-4567')
    end
    
    should "dial with action" do
      assert_equal verb_response(:dial_with_action), Twilio::Verb.new.dial('415-123-4567', :action => 'http://foobar.com')
    end
    
    should "dial with GET method" do
      assert_equal verb_response(:dial_with_get_method), Twilio::Verb.new.dial('415-123-4567', :method => 'GET')
    end
    
    should "dial with timeout" do
      assert_equal verb_response(:dial_with_timeout), Twilio::Verb.new.dial('415-123-4567', :timeout => 10)
    end
    
    should "dial with hangup on star" do
      assert_equal verb_response(:dial_with_hangup_on_star), Twilio::Verb.new.dial('415-123-4567', :hangupOnStar => true)
    end
    
    should "dial with time limit" do
      assert_equal verb_response(:dial_with_time_limit), Twilio::Verb.new.dial('415-123-4567', :timeLimit => 3600)
    end
    
    should "dial with caller id" do
      assert_equal verb_response(:dial_with_caller_id), Twilio::Verb.new.dial('415-123-4567', :callerId => '858-987-6543')
    end
    
    should "dial with timeout and caller id" do
      assert_equal verb_response(:dial_with_timeout_and_caller_id), Twilio::Verb.new.dial('415-123-4567', {:timeout => 10, :callerId => '858-987-6543'})
    end
    
    should "dial with redirect" do
      verb = Twilio::Verb.new { |v|
        v.dial('415-123-4567')
        v.redirect('http://www.foo.com/nextInstructions')
      }
      assert_equal verb_response(:dial_with_redirect), verb.response
    end
    
    should "dial with number and send digits" do
      verb = Twilio::Verb.new { |v|
        v.dial {
          v.number('415-123-4567', :sendDigits => 'wwww1928')
        }
      }
      assert_equal verb_response(:dial_with_number_and_send_digits), verb.response
    end
    
    should "dial multiple numbers" do
      verb = Twilio::Verb.new { |v|
        v.dial {
          v.number('415-123-4567')
          v.number('415-123-4568')
          v.number('415-123-4569')
        }
      }
      assert_equal verb_response(:dial_multiple_numbers), verb.response
    end
    
    should "hangup" do
      assert_equal verb_response(:hangup), Twilio::Verb.new.hangup
    end
    
    should "say hi and hangup" do
      verb = Twilio::Verb.new { |v|
        v.say('hi')
        v.hangup
      }
      assert_equal verb_response(:say_hi_and_hangup), verb.response
    end
  end
  
end