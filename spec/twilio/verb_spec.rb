require 'spec_helper'

describe "Verb" do
  
  context "Say" do
    it "says 'hi'" do
      Twilio::Verb.say('hi').should match %r{<Say( loop="1"| language="en"| voice="man"){3}>hi</Say>}
    end

    it "says 'hi' with female voice" do
      Twilio::Verb.say('hi', :voice => 'woman').should match %r{<Say( loop="1"| language="en"| voice="woman"){3}>hi</Say>}
    end

    it "says 'hola' in Spanish with female voice" do
      Twilio::Verb.say('hola', :voice => 'woman', :language => 'es').should match %r{<Say( loop="1"| language="es"| voice="woman"){3}>hola</Say>}
    end

    it "says 'hi' three times" do
      Twilio::Verb.say('hi', :loop => 3).should match %r{<Say( loop="3"| language="en"| voice="man"){3}>hi</Say>}
    end

    it "says 'hi' three times with pause" do
      Twilio::Verb.say('hi', :loop => 3, :pause => true).should match  %r{<Say( language="en"| voice="man"){2}>hi</Say><Pause/><Say( language="en"| voice="man"){2}>hi</Say><Pause/><Say( language="en"| voice="man"){2}>hi</Say>}
    end

    it "says 'hi' with pause and say 'bye'" do
      verb = Twilio::Verb.new { |v|
        v.say 'hi', :loop => 1
        v.pause
        v.say 'bye'
      }.response.should match %r{<Say( loop="1"| language="en"| voice="man"){3}>hi</Say><Pause></Pause><Say( loop="1"| language="en"| voice="man"){3}>bye</Say>}
    end

    it "says 'hi' with 2 second pause and say 'bye'" do
      verb = Twilio::Verb.new { |v|
        v.say 'hi'
        v.pause :length => 2
        v.say 'bye'
      }.response.should match %r{<Say( loop="1"| language="en"| voice="man"){3}>hi</Say><Pause length="2"/><Say( loop="1"| language="en"| voice="man"){3}>bye</Say>}
    end    
  end
  
  context "Play" do
    it "plays mp3 response" do
      Twilio::Verb.play('http://foo.com/cowbell.mp3').should == verb_response(:play_mp3)
    end

    it "plays mp3 response two times" do
      Twilio::Verb.play('http://foo.com/cowbell.mp3', :loop => 2).should == verb_response(:play_mp3_two_times)
    end

    it "plays mp3 response two times with pause" do
      Twilio::Verb.play('http://foo.com/cowbell.mp3', :loop => 2, :pause => true).should == verb_response(:play_mp3_two_times_with_pause)
    end
  end
  
  context "Gather" do
    it "gathers" do
      Twilio::Verb.gather.should == verb_response(:gather)
    end

    it "gathers with action" do
      Twilio::Verb.gather(:action => 'http://foobar.com').should == verb_response(:gather_with_action)
    end

    it "gathers with GET method" do
      Twilio::Verb.gather(:method => 'GET').should == verb_response(:gather_with_get_method)
    end

    it "gathers with timeout" do
      Twilio::Verb.gather(:timeout => 10).should == verb_response(:gather_with_timeout)
    end

    it "gathers with finish key" do
      Twilio::Verb.gather(:finishOnKey => '*').should == verb_response(:gather_with_finish_key)
    end

    it "gathers with num digits" do
      Twilio::Verb.gather(:numDigits => 5).should == verb_response(:gather_with_num_digits)
    end

    it "gathers with all options set" do
      Twilio::Verb.gather(:action      => 'http://foobar.com',
                          :finishOnKey => '*',
                          :method      => 'GET',
                          :numDigits   => 5,
                          :timeout     => 10).should match %r{<Gather( finishOnKey="\*"| action="http://foobar.com"| method="GET"| numDigits="5"| timeout="10"){5}/>}
    end

    it "gathers and says instructions" do
      verb = Twilio::Verb.new { |v|
        v.gather {
          v.say 'Please enter your account number followed by the pound sign'
        }
        v.say "We didn't receive any input. Goodbye!"
      }.response.should match %r{<Gather><Say( loop="1"| language="en"| voice="man"){3}>Please enter your account number followed by the pound sign</Say></Gather><Say( loop="1"| language="en"| voice="man"){3}>We didn't receive any input. Goodbye!</Say>}
    end

    it "gathers with timeout and says instructions" do
      verb = Twilio::Verb.new { |v|
        v.gather(:timeout => 10) {
          v.say 'Please enter your account number followed by the pound sign'
        }
        v.say "We didn't receive any input. Goodbye!"
      }.response.should match %r{<Gather timeout="10"><Say( loop="1"| language="en"| voice="man"){3}>Please enter your account number followed by the pound sign</Say></Gather><Say( loop="1"| language="en"| voice="man"){3}>We didn't receive any input. Goodbye!</Say>}
    end
  end

  context "Record" do
    it "records" do
      Twilio::Verb.record.should == verb_response(:record)
    end

    it "records with action" do
      Twilio::Verb.record(:action => 'http://foobar.com').should == verb_response(:record_with_action)
    end

    it "records with GET method" do
      Twilio::Verb.record(:method => 'GET').should == verb_response(:record_with_get_method)
    end

    it "records with timeout" do
      Twilio::Verb.record(:timeout => 10).should == verb_response(:record_with_timeout)
    end

    it "records with finish key" do
      Twilio::Verb.record(:finishOnKey => '*').should == verb_response(:record_with_finish_key)
    end

    it "records with max length" do
      Twilio::Verb.record(:maxLength => 1800).should == verb_response(:record_with_max_length)
    end

    it "records with transcribe" do
      Twilio::Verb.record(:transcribe => true, :transcribeCallback => '/handle_transcribe').should match %r{<Record( transcribe="true"| transcribeCallback="/handle_transcribe"){2}/>}
    end
  end

  context "Dial" do
    it "dials" do
      Twilio::Verb.dial('415-123-4567').should == verb_response(:dial)
    end

    it "dials with action" do
      Twilio::Verb.dial('415-123-4567', :action => 'http://foobar.com').should == verb_response(:dial_with_action)
    end

    it "dials with GET method" do
      Twilio::Verb.dial('415-123-4567', :method => 'GET').should == verb_response(:dial_with_get_method)
    end

    it "dials with timeout" do
      Twilio::Verb.dial('415-123-4567', :timeout => 10).should == verb_response(:dial_with_timeout)
    end

    it "dials with hangup on star" do
      Twilio::Verb.dial('415-123-4567', :hangupOnStar => true).should == verb_response(:dial_with_hangup_on_star)
    end

    it "dials with time limit" do
      Twilio::Verb.dial('415-123-4567', :timeLimit => 3600).should == verb_response(:dial_with_time_limit)
    end

    it "dials with caller id" do
      Twilio::Verb.dial('415-123-4567', :callerId => '858-987-6543').should == verb_response(:dial_with_caller_id)
    end

    it "dials with timeout and caller id" do
      Twilio::Verb.dial('415-123-4567', :timeout  => 10, :callerId => '858-987-6543').should match %r{<Dial( timeout="10"| callerId="858-987-6543"){2}>415-123-4567</Dial>}
    end

    it "dials with redirect" do
      verb = Twilio::Verb.new { |v|
        v.dial '415-123-4567'
        v.redirect 'http://www.foo.com/nextInstructions'
      }.response.should == verb_response(:dial_with_redirect)
    end

    it "dials with number and send digits" do
      verb = Twilio::Verb.new { |v|
        v.dial {
          v.number('415-123-4567', :sendDigits => 'wwww1928')
        }
      }.response.should == verb_response(:dial_with_number_and_send_digits)
    end

    it "dials multiple numbers" do
      verb = Twilio::Verb.new { |v|
        v.dial {
          v.number '415-123-4567'
          v.number '415-123-4568'
          v.number '415-123-4569'
        }
      }.response.should == verb_response(:dial_multiple_numbers)
    end

    it "dials a conference" do
      verb = Twilio::Verb.new { |v|
        v.dial {
          v.conference 'MyRoom'
        }
      }.response.should == verb_response(:dial_conference)
    end

    it "dials a muted conference" do
      verb = Twilio::Verb.new { |v|
        v.dial {
          v.conference 'MyRoom', :mute => :true
        }
      }.response.should == verb_response(:dial_muted_conference)
    end
  end
  
  context "Hang Up" do
    it "hangs up" do
      Twilio::Verb.hangup.should == verb_response(:hangup)
    end

    it "says hi and hangs up" do
      verb = Twilio::Verb.new { |v|
        v.say 'hi'
        v.hangup
      }.response.should match %r{<Say( loop="1"| language="en"| voice="man"){3}>hi</Say><Hangup/>}
    end
  end
  
  context "Reject" do
    it "rejects" do
      Twilio::Verb.reject.should == verb_response(:reject)
    end

    it "just rejects incoming call" do
      verb = Twilio::Verb.new { |v|
        v.reject
      }.response.should match %r{<Reject/>}
    end

    it "just rejects incoming call with 'busy' status" do
      verb = Twilio::Verb.new { |v|
        v.reject :reason => 'busy'
      }.response.should match %r{<Reject reason="busy"/>}
    end
  end
  
  context "SMS" do
    it "sends a simple SMS message" do
      verb = Twilio::Verb.new { |v|
        v.sms 'Join us at the bar', :to => "8005554321", :from => "9006661111", :action => "/smsService", :method => "GET"
      }.response.should match %r{<Sms( to="8005554321"| from="9006661111"| action="/smsService"| method="GET"){4}>Join us at the bar</Sms>}
    end
  end

end
