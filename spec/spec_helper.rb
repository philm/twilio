require 'bundler'
Bundler.setup

require 'twilio'

require 'support/twilio_helpers'
require 'webmock/rspec'

RSpec.configure do |config|   
  config.include TwilioHelpers
  config.before(:suite) do
    WebMock.disable_net_connect!
  end
  config.after(:suite) do
    WebMock.allow_net_connect!
  end
end