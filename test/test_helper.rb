require 'rubygems'
require 'test/unit'
require 'fakeweb'
require 'shoulda'
require 'matchy'
require 'yaml'

FakeWeb.allow_net_connect = false

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'twilio'

class Test::Unit::TestCase
end

def fixture(filename)
  path = File.join(File.dirname(__FILE__), "fixtures/xml/#{filename}.xml")
  File.read path
end

def twilio_url(url=nil)
  "https://mysid:mytoken@api.twilio.com:443/2008-08-01/Accounts/mysid#{'/' + url if url}"
end

def verb_response(verb)
  path = File.join(File.dirname(__FILE__), "fixtures/yml/verb_responses.yml")
  YAML.load_file(path)[verb.to_s]['response']
end