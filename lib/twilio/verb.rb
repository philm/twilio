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
      # Optional params (see http://www.twilio.com/docs/api_reference/TwiML/say) are passed in as a hash:
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
      
      #  The Play verb plays an audio URL back to the caller. 
      # Examples:
      #   Twilio::Verb.play('http://foo.com/cowbell.mp3')
      #   Twilio::Verb.play_3_times('http://foo.com/cowbell.mp3')
      #
      # If you need a longer pause between each loop, use the pause form:
      #
      #   Twilio::Verb.play_3_times_with_pause('http://foo.com/cowbell.mp3')
      #
      # Optional params (see http://www.twilio.com/docs/api_reference/TwiML/play) are passed in as a hash,
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
            
      def gather(*args, &block)
        options = args.shift
        
        xml = Builder::XmlMarkup.new
        xml.instruct!
        xml.Response {
          xml.Gather(options)       
        }
      end
      
      #Not yet implemented 
      def record(options = {})
        raise NotImplementedError.new 'Not yet implemented - coming soon'
      end
      
      #Not yet implemented 
      def dial(phone_number, options = {})
        raise NotImplementedError.new 'Not yet implemented - coming soon'
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