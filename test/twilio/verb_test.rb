require File.dirname(__FILE__) + '/../test_helper'

class VerbTest < Test::Unit::TestCase
  context "A Twilio Verb" do
    should "say 'Hi'" do
      assert_equal verb_response(:say_hi), Twilio::Verb.say('hi')
    end
    
    should "say 'Hi' three times" do
      assert_equal verb_response(:say_hi_three_times), Twilio::Verb.say_3_times('hi')
    end
    
    should "say 'Hi' three times with pause" do
      assert_equal verb_response(:say_hi_three_times_with_pause), Twilio::Verb.say_3_times_with_pause('hi')
    end
    
    should "raise not implemented error with play" do
      assert_raise(NotImplementedError) { Twilio::Verb.play('something') }
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