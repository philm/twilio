require 'test_helper'

class AccountTest < Test::Unit::TestCase #:nodoc: all
  context "An account" do
    setup do
      Twilio.connect('mysid', 'mytoken')
    end

    should "be retrievable" do
      assert_equal stub_response(:get, :account), Twilio::Account.get
    end
    
    should "be able to update name" do
      assert_equal stub_response(:put, :account_renamed), Twilio::Account.update_name('Bubba')
    end 
    
    context "using deprecated API" do
      setup do
        @connection = Twilio::Connection.new('mysid', 'mytoken')
        @account = Twilio::Account.new(@connection)
      end

      should "be retrievable" do
        assert_equal stub_response(:get, :account), @account.get
      end
    end
  end
end