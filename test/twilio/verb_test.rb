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
      assert_equal verb_response(:gather_with_all_options_set), Twilio::Verb.gather({:action => 'http://foobar.com', :method => 'GET', :timeout => 10, :finishOnKey => '*', :numDigits => 5})
    end
    
    should "raise not implemented error with record" do
      assert_raise(NotImplementedError) { Twilio::Verb.record('something') }
    end
    
    should "raise not implemented error with dial" do
      assert_raise(NotImplementedError) { Twilio::Verb.record('dial') }
    end
  end
  
end