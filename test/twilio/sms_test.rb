require File.dirname(__FILE__) + '/../test_helper'

class SmsTest < Test::Unit::TestCase #:nodoc: all
  context "A call" do
    setup do
      Twilio.connect('mysid', 'mytoken')
    end

    should "be messaged" do
      assert_equal stub_response(:post, :sms_new, :resource => 'SMS/Messages'),
        Twilio::Sms.message('4155551212', '5558675309', 'Hi Jenny! Want to grab dinner?')
    end
    should "be messaged with a callback URL" do
      assert_equal stub_response(:post, :sms_new_with_callback, :resource => 'SMS/Messages'),
        Twilio::Sms.message('4155551212', '5558675309', 'Hi Jenny! Want to grab dinner?', 'http://example.com/callback')
    end

    should "be retrievable as a list" do
      assert_equal stub_response(:get, :sms_messages, :resource => 'SMS/Messages'), Twilio::Sms.list
    end

    should "retrieve an individual sms" do
      assert_equal stub_response(:get, :sms, :resource => 'SMS/Messages/SM872fb94e3b358913777cdb313f25b46f'),
        Twilio::Sms.get('SM872fb94e3b358913777cdb313f25b46f')
    end
  end
end