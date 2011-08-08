module Twilio
  # Twilio Verbs enable your application to respond to Twilio requests (to your app) with XML responses.
  # There are 5 primary verbs (say, play, gather, record, dial) and 3 secondary (hangup, pause, redirect).
  # Verbs can be chained and, in some cases, nested.
  #
  # If your response consists of a single verb, you can call a Verb class method:
  #
  #   Twilio::Verb.say 'The time is 9:35 PM.'
  #
  # But if you need to chain several verbs together, just wrap them in an instance block and call the 'response' attribute:
  #
  #   verb = Twilio::Verb.new { |v|
  #     v.dial '415-123-4567'
  #     v.redirect 'http://www.foo.com/nextInstructions'
  #   }
  #   verb.response
  class Verb

    attr_reader :response

    class << self
      def method_missing(method_id, *args) #:nodoc:
        v = Verb.new
        v.send(method_id, *args)
      end
    end

    def initialize(&block)
      @xml = Builder::XmlMarkup.new
      @xml.instruct!

      if block_given?
        @chain = true
        @response = @xml.Response { block.call(self) }
      end
    end

    # The Say verb converts text to speech that is read back to the caller.
    # Say is useful for dynamic text that is difficult to prerecord.
    #
    # Examples:
    #   Twilio::Verb.say 'The time is 9:35 PM.'
    #   Twilio::Verb.say 'The time is 9:35 PM.', :loop => 3
    #
    # With numbers, 12345 will be spoken as "twelve thousand three hundred forty five" while
    # 1 2 3 4 5 will be spoken as "one two three four five."
    #
    #   Twilio::Verb.say 'Your PIN is 1234', :loop => 4
    #   Twilio::Verb.say 'Your PIN is 1 2 3 4', :loop => 4
    #
    # If you need a longer pause between each loop, instead of explicitly calling the Pause
    # verb within a block, you can set the convenient pause option:
    #
    #   Twilio::Verb.say 'Your PIN is 1 2 3 4', :loop => 4, :pause => true
    #
    # Options (see http://www.twilio.com/docs/api_reference/TwiML/say) are passed in as a hash:
    #
    #   Twilio::Verb.say 'The time is 9:35 PM.', :voice => 'woman'
    #   Twilio::Verb.say 'The time is 9:35 PM.', :voice => 'woman', :language => 'es'
    def say(*args)
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

      output {
        if options[:pause]
          loop_with_pause(options[:loop], @xml) do
            @xml.Say(options[:text_to_speak], :voice => options[:voice], :language => options[:language])
          end
        else
          @xml.Say(options[:text_to_speak], :voice => options[:voice], :language => options[:language], :loop => options[:loop])
        end
      }
    end

    # The Play verb plays an audio URL back to the caller.
    # Examples:
    #   Twilio::Verb.play 'http://foo.com/cowbell.mp3'
    #   Twilio::Verb.play 'http://foo.com/cowbell.mp3', :loop => 3
    #
    # If you need a longer pause between each loop, instead of explicitly calling the Pause
    # verb within a block, you can set the convenient pause option:
    #
    #   Twilio::Verb.play 'http://foo.com/cowbell.mp3', :loop => 3, :pause => true
    #
    # Options (see http://www.twilio.com/docs/api_reference/TwiML/play) are passed in as a hash,
    # but only 'loop' is currently supported.
    def play(*args)
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

      output {
        if options[:pause]
          loop_with_pause(options[:loop], @xml) do
            @xml.Play(options[:audio_url])
          end
        else
          @xml.Play(options[:audio_url], :loop => options[:loop])
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
    #   Twilio::Verb.gather :action => 'http://foobar.com'
    #   Twilio::Verb.gather :finishOnKey => '*'
    #   Twilio::Verb.gather :action => 'http://foobar.com', :finishOnKey => '*'
    #
    # Gather also lets you nest the Play, Say, and Pause verbs:
    #
    #   verb = Twilio::Verb.new { |v|
    #     v.gather(:action => '/process_gather', :method => 'GET) {
    #       v.say 'Please enter your account number followed by the pound sign'
    #     }
    #     v.say "We didn't receive any input. Goodbye!"
    #   }
    #   verb.response # represents the final xml output
    def gather(*args, &block)
      options = args.shift || {}
      output {
        if block_given?
          @xml.Gather(options) { block.call}
        else
          @xml.Gather(options)
        end
      }
    end

    #play, say, pause

    # The Record verb records the caller's voice and returns a URL that links to a file
    # containing the audio recording.
    #
    # Options (see http://www.twilio.com/docs/api_reference/TwiML/record) are passed in as a hash
    #
    # Examples:
    #   Twilio::Verb.record
    #   Twilio::Verb.record :action => 'http://foobar.com'
    #   Twilio::Verb.record :finishOnKey => '*'
    #   Twilio::Verb.record :transcribe => true, :transcribeCallback => '/handle_transcribe'
    def record(*args)
      options = args.shift
      output { @xml.Record(options) }
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
    #   Twilio::Verb.dial '415-123-4567'
    #   Twilio::Verb.dial '415-123-4567', :action => 'http://foobar.com'
    #   Twilio::Verb.dial '415-123-4567', :timeout => 10, :callerId => '858-987-6543'
    #
    # Twilio also supports an alternate form in which a Number object is nested inside Dial:
    #
    #   verb = Twilio::Verb.new { |v|
    #     v.dial { |v|
    #       v.number '415-123-4567'
    #       v.number '415-123-4568'
    #       v.number '415-123-4569'
    #     }
    #   }
    #   verb.response # represents the final xml output
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

      output {
        if block_given?
          @xml.Dial(options) { block.call }
        else
          @xml.Dial(number_to_dial, options)
        end
      }
    end

    # The <Dial> verb's <Conference> noun allows you to connect to a conference room.
    # Much like how the <Number> noun allows you to connect to another phone number,
    # the <Conference> noun allows you to connect to a named conference room and talk
    # with the other callers who have also connected to that room.
    #
    # Options (see http://www.twilio.com/docs/api_reference/TwiML/conference) are passed in as a hash
    #
    # Examples:
    #   verb = Twilio::Verb.new { |v|
    #     v.dial {
    #       v.conference 'MyRoom', :muted => true
    #     }
    #   }
    #   verb.response
    def conference(*args)
      conference_name = ''
      options = {}
      args.each do |arg|
        case arg
        when String
          conference_name = arg
        when Hash
          options.merge!(arg)
        else
          raise ArgumentError, 'conference expects String or Hash argument'
        end
      end

      output { @xml.Conference(conference_name, options)}
    end

    # The Pause (secondary) verb waits silently for a number of seconds.
    # It is normally chained with other verbs.
    #
    # Options (see http://www.twilio.com/docs/api_reference/TwiML/pause) are passed in as a hash
    #
    # Examples:
    #   verb = Twilio::Verb.new { |v|
    #     v.say 'greetings'
    #     v.pause :length => 2
    #     v.say 'have a nice day'
    #   }
    #   verb.response
    def pause(*args)
      options = args.shift
      output { @xml.Pause(options) }
    end

    # The Redirect (secondary) verb transfers control to a different URL.
    # It is normally chained with other verbs.
    #
    # Options (see http://www.twilio.com/docs/api_reference/TwiML/redirect) are passed in as a hash
    #
    # Examples:
    #   verb = Twilio::Verb.new { |v|
    #     v.dial '415-123-4567'
    #     v.redirect 'http://www.foo.com/nextInstructions'
    #   }
    #   verb.response
    def redirect(*args)
      redirect_to_url = ''
      options = {}
      args.each do |arg|
        case arg
        when String
          redirect_to_url = arg
        when Hash
          options.merge!(arg)
        else
          raise ArgumentError, 'dial expects String or Hash argument'
        end
      end

      output { @xml.Redirect(redirect_to_url, options) }
    end

    # The <Sms> verb sends a SMS message to a phone number.
    #
    # Options (see http://www.twilio.com/docs/api/2008-08-01/twiml/sms/sms) ars passed in as a hash
    #
    # Examples:
    #   verb = Twilio::Verb.new { |v|
    #     v.sms 'Meet at South Street'
    #   }
    #
    def sms(*args)
      message = ''
      options = {}
      args.each do |arg|
        case arg
        when String
          message = arg
        when Hash
          options.merge!(arg)
        else
          raise ArgumentError, 'sms expects STring or Hash argument'
        end
      end

      output { @xml.Sms(message, options) }
    end

    # The Hangup (secondary) verb ends the call.
    #
    # Examples:
    #   If your response is only a hangup:
    #
    #   Twilio::Verb.hangup
    #
    #   If your response is chained:
    #
    #   verb = Twilio::Verb.new { |v|
    #     v.say "The time is #{Time.now}"
    #     v.hangup
    #   }
    #   verb.response
    def hangup
      output { @xml.Hangup }
    end

    # The Number element specifies a phone number. The number element has two optional attributes: sendDigits and url.
    # Number elements can only be nested in Dial verbs
    def number(*args)
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

      output { @xml.Number(number_to_dial, options) }
    end


    # The Reject verb refuse the call
    # Examples:
    #
    #   Twilio::Verb.reject
    #
    #   If reject called with argument:
    # 
    #   Twilio::Verb.reject :reason => "busy"
    #
    def reject options = {}
      output { @xml.Reject(options) }
    end

    private

      def output
        @chain ? yield : @xml.Response { yield }
      end

      def loop_with_pause(loop_count, xml, &verb_action)
        last_iteration = loop_count-1
        loop_count.times do |i|
          yield verb_action
          xml.Pause unless i == last_iteration
        end
      end
  end
end
