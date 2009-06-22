module Twilio
  # Twilio Verbs enable your application to respond to Twilio requests (to your app) with XML responses.
  #
  # In addition to the 5 verbs supported by Twilio (say, play, gather, record, dial),
  # this class also implements dynamic interfaces that allow you to combine useful
  # operations into a single call. See below methods for examples.
  class Verb
    class << self
      # The Say verb converts text to speech that is read back to the caller. 
      # Say is useful for dynamic text that is difficult to prerecord. 
      #
      # Examples:
      #   Twilio::Verb.say('The time is 9:35 PM.')
      #   Twilio::Verb.say_3_times('The time is 9:35 PM.')
      #
      # With numbers, 12345 will be spoken as "twelve thousand three hundred forty five" while
      # 1 2 3 4 5 will be spoken as "one two three four five."
      #
      #   Twilio::Verb.say_4_times('Your PIN is 1234')
      #   Twilio::Verb.say_4_times('Your PIN is 1 2 3 4')
      # 
      # If you need a longer pause between each loop, use the pause form:
      #
      #   Twilio::Verb.say_4_times_with_pause('Your PIN is 1 2 3 4')
      #
      # Options (see http://www.twilio.com/docs/api_reference/TwiML/say) are passed in as a hash:
      #
      #   Twilio::Verb.say('The time is 9:35 PM.', :voice => 'woman')
      #   Twilio::Verb.say('The time is 9:35 PM.', {:voice => 'woman', :language => 'es'})
      def say(*args, &block)
        options = {:voice => 'man', :language => 'en', :loop => 1}
        args.each do |arg|
          case arg
          when String
            options[:text_to_speak] = arg
          when Hash
            options.merge!(arg)
          else
            raise ArgumentError, 'say expects String or Hash argument'
          end
        end
        
        xml = Builder::XmlMarkup.new
        xml.instruct!
        xml.Response {
          if options[:pause]
            loop_with_pause(options[:loop], xml) do
              xml.Say(options[:text_to_speak], :voice => options[:voice], :language => options[:language])
            end
          else
            xml.Say(options[:text_to_speak], :voice => options[:voice], :language => options[:language], :loop => options[:loop])
          end
        }
      end
      
      # The Play verb plays an audio URL back to the caller. 
      # Examples:
      #   Twilio::Verb.play('http://foo.com/cowbell.mp3')
      #   Twilio::Verb.play_3_times('http://foo.com/cowbell.mp3')
      #
      # If you need a longer pause between each loop, use the pause form:
      #
      #   Twilio::Verb.play_3_times_with_pause('http://foo.com/cowbell.mp3')
      #
      # Options (see http://www.twilio.com/docs/api_reference/TwiML/play) are passed in as a hash,
      # however, since the Play verb only supports 'loop' as the current option, you can instead use the
      # above form to keep things concise. 
      def play(*args, &block)
        options = {:loop => 1}
        args.each do |arg|
          case arg
          when String
            options[:audio_url] = arg
          when Hash
            options.merge!(arg)
          else
            raise ArgumentError, 'play expects String or Hash argument'
          end
        end

        xml = Builder::XmlMarkup.new
        xml.instruct!
        xml.Response {
          if options[:pause]
            loop_with_pause(options[:loop], xml) do
              xml.Play(options[:audio_url])
            end
          else
            xml.Play(options[:audio_url], :loop => options[:loop])
          end          
        }
      end
      
      # The Gather verb collects digits entered by a caller into their telephone keypad. 
      # When the caller is done entering data, Twilio submits that data to a provided URL, 
      # as either a HTTP GET or POST request, just like a web browser submits data from an HTML form. 
      #
      # Options (see http://www.twilio.com/docs/api_reference/TwiML/gather) are passed in as a hash
      #
      # Examples:
      #   Twilio::Verb.gather
      #   Twilio::Verb.gather(:action => 'http://foobar.com')
      #   Twilio::Verb.gather(:finishOnKey => '*') 
      #   Twilio::Verb.gather(:action => 'http://foobar.com', :finishOnKey => '*') 
      def gather(*args, &block)
        options = args.shift
        xml = Builder::XmlMarkup.new
        xml.instruct!
        xml.Response { xml.Gather(options) }
      end
      
      # The Record verb records the caller's voice and returns a URL that links to a file 
      # containing the audio recording.
      #
      # Options (see http://www.twilio.com/docs/api_reference/TwiML/record) are passed in as a hash
      #
      # Examples:
      #   Twilio::Verb.record
      #   Twilio::Verb.record(:action => 'http://foobar.com')
      #   Twilio::Verb.record(:finishOnKey => '*') 
      #   Twilio::Verb.record(:transcribe => true, :transcribeCallback => '/handle_transcribe')
      def record(*args, &block)
        options = args.shift
        xml = Builder::XmlMarkup.new
        xml.instruct!
        xml.Response { xml.Record(options) }
      end
      
      # The Dial verb connects the current caller to an another phone. If the called party picks up, 
      # the two parties are connected and can communicate until one hangs up. If the called party does 
      # not pick up, if a busy signal is received, or the number doesn't exist, the dial verb will finish.
      #
      # If an action verb is provided, Twilio will submit the outcome of the call attempt to the action URL. 
      # If no action is provided, Dial will fall through to the next verb in the document.
      #
      # Note: this is different than the behavior of Record and Gather. Dial does not submit back to the 
      # current document URL if no action is provided.
      #
      # Options (see http://www.twilio.com/docs/api_reference/TwiML/dial) are passed in as a hash
      #
      # Examples:
      #   Twilio::Verb.dial('415-123-4567')
      #   Twilio::Verb.dial('415-123-4567', :action => 'http://foobar.com')
      #   Twilio::Verb.dial('415-123-4567', {:timeout => 10, :callerId => '858-987-6543'}) 
      def dial(*args, &block)
        number_to_dial = ''
        options = {}
        args.each do |arg|
          case arg
          when String
            number_to_dial = arg
          when Hash
            options.merge!(arg)
          else
            raise ArgumentError, 'dial expects String or Hash argument'
          end
        end
        
        xml = Builder::XmlMarkup.new
        xml.instruct!
        xml.Response { xml.Dial(number_to_dial, options) }
      end

      def method_missing(method_id, *args) #:nodoc:
        if match = /(say|play|gather|record|dial)_(\d+)_times(_with_pause$*)/.match(method_id.to_s)
          verb = match.captures.first 
          how_many_times = match.captures[1]
          pause = match.captures[2] == '_with_pause'
          self.send(verb, args.first, { :loop => Integer(how_many_times), :pause =>  pause})
        else
          raise NoMethodError.new("Method --- #{method_id} --- not found")
        end
      end
            
      private 
      
        def loop_with_pause(loop_count, xml, &verb_action)
          last_iteration = loop_count-1                               
          loop_count.times do |i|
            yield verb_action
            xml.Pause unless i == last_iteration
          end
        end
    end
  end
end