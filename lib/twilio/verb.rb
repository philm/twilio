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
      # Optional params passed in as a hash (see http://www.twilio.com/docs/api_reference/TwiML/say):
      #    voice: (woman) man
      #    language: (en) es fr de
      #    loop: >= 0 (1)
      def say(text, options = {})
        voice = options[:voice] || 'woman'
        language = options[:language] || 'en'        
        loop_count = Integer(options[:loop]  || 1)
        pause = options[:pause]
        
        xml = Builder::XmlMarkup.new
        xml.instruct!
        xml.Response {
          if pause
            loop_with_pause(loop_count, xml) do
              xml.Say(text, :voice => voice, :language => language)
            end
          else
            xml.Say(text, :voice => voice, :language => language, :loop => loop_count)
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
      # Optional params passed in as a hash (see http://www.twilio.com/docs/api_reference/TwiML/play):
      #    loop: >= 0 (1)      
      def play(audio_url, options = {})
        loop_count = Integer(options[:loop]  || 1)
        pause = options[:pause]
        
        xml = Builder::XmlMarkup.new
        xml.instruct!
        xml.Response {
          if pause
            loop_with_pause(loop_count, xml) do
              xml.Play(audio_url)
            end
          else
            xml.Play(audio_url, :loop => loop_count)
          end          
        }
      end
      
      def loop_with_pause(loop_count, xml, &verb_action)
        last_iteration = loop_count-1                               
        loop_count.times do |i|
          yield verb_action
          xml.Pause unless i == last_iteration
        end
      end
      
      #Not yet implemented 
      def gather(options = {})
        raise NotImplementedError.new 'Not yet implemented - coming soon'
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
          self.send(verb, args.first, { :loop => how_many_times, :pause =>  pause})
        end
      end
    end
  end
end