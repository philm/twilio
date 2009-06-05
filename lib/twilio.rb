$:.unshift(File.dirname(__FILE__))

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

require 'rubygems'
gem 'httparty', '>= 0.4.3'
require 'httparty'
gem 'builder', '>= 2.1.2'
require 'builder'

require 'twilio/twilio_object'
require 'twilio/account'
require 'twilio/call'
require 'twilio/connection'
require 'twilio/incoming_phone_number'
require 'twilio/local_phone_number'
require 'twilio/notification'
require 'twilio/outgoing_caller_id'
require 'twilio/recording'
require 'twilio/toll_free_phone_number'
require 'twilio/verb'