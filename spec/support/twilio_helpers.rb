module TwilioHelpers #:nodoc:
  
  def stub_http_request(http_method, fixture_name, *opts)    
    if opts
      request_options = opts.pop if opts.last.is_a?(Hash)
      resource = opts.pop
    end
    
    fake_response = fixture(fixture_name)         
    url = twilio_url(resource)
    
    if request_options
      stub_request(http_method, url).with(request_options).to_return(:body => fake_response)
    else
      stub_request(http_method, url).to_return(:body => fake_response)
    end
    
    return fake_response, url
  end
    
  def stub_get(fixture, *opts)
    stub_http_request(:get, fixture, *opts)  
  end
  
  def stub_post(fixture, *opts)
    stub_http_request(:post, fixture, *opts)
  end
  
  def stub_put(fixture, *opts)
    stub_http_request(:put, fixture, *opts)
  end
  
  def stub_delete(fixture, *opts)
    stub_http_request(:delete, fixture, *opts)
  end

  def verb_response(verb)
    path = File.join(File.dirname(__FILE__), "../fixtures/yml/verb_responses.yml")
    YAML.load_file(path)[verb.to_s]['response']
  end
      
  private
  
    def twilio_url(url=nil)
      "https://mysid:mytoken@api.twilio.com:443/2010-04-01/Accounts/mysid#{'/' + url if url}"
    end

    def fixture(filename)
      path = File.join(File.dirname(__FILE__), "../fixtures/xml/#{filename}.xml")
      File.read path
    end
end