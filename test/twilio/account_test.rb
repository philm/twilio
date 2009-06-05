require File.dirname(__FILE__) + '/../test_helper'

class AccountTest < Test::Unit::TestCase #:nodoc: all
  context "An account" do
    setup do
      @connection = Twilio::Connection.new('mysid', 'mytoken')
      @account = Twilio::Account.new(@connection)
    end

    should "be retrievable" do
      fake_response = fixture(:account)
      FakeWeb.register_uri(:get, twilio_url, :string => fake_response)
      assert_equal @account.get, fake_response
    end
    
    should "be able to update name" do
      fake_response = fixture(:account_renamed)
      FakeWeb.register_uri(:put, twilio_url, :string => fake_response)
      response = @account.update_name('Bubba')
      assert_equal response, fake_response
    end 
  end
end