require 'test/unit'
require 'fakeweb'
require 'shoulda'
require 'yaml'
require 'twilio'

FakeWeb.allow_net_connect = false

class Test::Unit::TestCase #:nodoc: all
end

def fixture(filename) #:nodoc:
  path = File.join(File.dirname(__FILE__), "fixtures/xml/#{filename}.xml")
  File.read path
end

def stub_response(verb, fixture_name, options = {}) #:nodoc:
  fake_response = fixture(fixture_name)
  resource = options.delete(:resource)
  options = { :body => fake_response }.merge(options)
  FakeWeb.register_uri(verb, twilio_url(resource), options)
  
  fake_response
end

def twilio_url(url=nil) #:nodoc:
  "https://mysid:mytoken@api.twilio.com:443/2010-04-01/Accounts/mysid#{'/' + url if url}"
end

def verb_response(verb) #:nodoc:
  path = File.join(File.dirname(__FILE__), "fixtures/yml/verb_responses.yml")
  YAML.load_file(path)[verb.to_s]['response']
end