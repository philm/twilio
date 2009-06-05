require File.dirname(__FILE__) + '/../test_helper'

class VerbTest < Test::Unit::TestCase #:nodoc: all
  context "A Twilio Verb" do
    should "say 'hi'" do
      assert_equal verb_response(:say_hi), Twilio::Verb.say('hi')
    end
    
    should "say 'hola' in Spanish with male voice" do
      assert_equal verb_response(:say_hi_in_spanish_with_male_voice), Twilio::Verb.say('hola', {:voice => 'man', :language => 'es'})
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
     
    should "raise not implemented error with gather" do
      assert_raise(NotImplementedError) { Twilio::Verb.gather('something') }
    end
    
    should "raise not implemented error with record" do
      assert_raise(NotImplementedError) { Twilio::Verb.record('something') }
    end
    
    should "raise not implemented error with dial" do
      assert_raise(NotImplementedError) { Twilio::Verb.record('dial') }
    end
  end
  
end