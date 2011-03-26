#--
# Copyright (c) 2009 Phil Misiowiec, phil@webficient.com
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#++

require 'httparty'
require 'builder'

require 'twilio/twilio_object'

require 'twilio/account'
require 'twilio/available_phone_numbers'
require 'twilio/call'
require 'twilio/conference'
require 'twilio/incoming_phone_number'
require 'twilio/notification'
require 'twilio/outgoing_caller_id'
require 'twilio/recording'
require 'twilio/sms'
require 'twilio/verb'

module Twilio  
  include HTTParty
  TWILIO_URL = "https://api.twilio.com/2010-04-01/Accounts"
  SSL_CA_PATH = "/etc/ssl/certs"
  
  # The connect method caches your Twilio account id and authentication token
  # Example:
  #  Twilio.connect('AC309475e5fede1b49e100272a8640f438', '3a2630a909aadbf60266234756fb15a0')
  def self.connect(account_sid, auth_token)
    self.base_uri "#{TWILIO_URL}/#{account_sid}"
    self.basic_auth account_sid, auth_token
    self.default_options[:ssl_ca_path] ||= SSL_CA_PATH unless self.default_options[:ssl_ca_file]
  end  
end
