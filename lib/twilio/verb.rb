module Twilio
  class Verb
    class << self
      def say(text, options = {})
        voice = options[:voice] || 'woman'
        language = options[:language] || 'en'
        loop_count = Integer(options[:loop]  || 1)
        pause = options[:pause]
        
        xml = Builder::XmlMarkup.new
        xml.instruct!
        xml.Response {
          if pause
            loop_count.times do |i|
              xml.Say(text, :voice => voice, :language => language, :loop => 1)
              xml.Pause unless i+1 == loop_count
            end
          else
            xml.Say(text, :voice => voice, :language => language, :loop => loop_count)
          end
        }
      end
      
      def play(audio_url, options = {})
        raise NotImplementedError.new 'Not yet implemented - coming soon'
      end
      
      def gather(options = {})
        raise NotImplementedError.new 'Not yet implemented - coming soon'
      end
      
      def record(options = {})
        raise NotImplementedError.new 'Not yet implemented - coming soon'
      end
      
      def dial(phone_number, options = {})
        raise NotImplementedError.new 'Not yet implemented - coming soon'
      end
      
      def method_missing(method_id, *args)
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

#Twilio::Verb.say_3_times("Your pin code is #{@random_code}")
#Twilio::Verb.say_3_times_with_pause("Your pin code is #{@random_code}")