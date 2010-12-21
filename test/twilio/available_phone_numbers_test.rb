require 'test_helper'

class AvailablePhoneNumbersTest < Test::Unit::TestCase #:nodoc: all
  context "Available Number Searching" do
    setup do
      Twilio.connect('mysid', 'mytoken')
    end

    context "Local Numbers" do
      should "be searchable" do
        assert_equal stub_response(:get, :available_phone_numbers_local, :resource => 'AvailablePhoneNumbers/US/Local'),
          Twilio::AvailablePhoneNumbers.search_local
      end

      should "be searchable by area code" do
        assert_equal stub_response(:get, :available_phone_numbers_local_search, :resource => 'AvailablePhoneNumbers/US/Local?AreaCode=510'),
          Twilio::AvailablePhoneNumbers.search_local(:area_code => 510)
      end

      should "be searchable by Postal Code" do
        assert_equal stub_response(:get, :available_phone_numbers_local_search, :resource => 'AvailablePhoneNumbers/US/Local?InPostalCode=94612'),
          Twilio::AvailablePhoneNumbers.search_local(:postal_code => 94612)
      end

      should "be searchable by the rest of the paramters" do
        assert_equal stub_response(:get, :available_phone_numbers_local_search, :resource => 'AvailablePhoneNumbers/US/Local?NearLatLong=37.806940%2C-122.270360&InRateCenter=OKLD0349T&NearNumber=15105551213&Distance=50&InRegion=CA&InLata=722&Contains=510555****'),
          Twilio::AvailablePhoneNumbers.search_local(:in_region => 'CA', :contains => '510555****', :near_lat_long => '37.806940,-122.270360', :near_number => '15105551213', :in_lata => 722, :in_rate_center => 'OKLD0349T', :distance => 50)
      end
    end

    context "Toll-free numbers" do
      should "be searchable" do
        assert_equal stub_response(:get, :available_phone_numbers_toll_free, :resource => 'AvailablePhoneNumbers/US/TollFree'),
          Twilio::AvailablePhoneNumbers.search_toll_free
      end

      should "be able to find vanity numbers" do
        assert_equal stub_response(:get, :available_phone_numbers_toll_free_search, :resource => 'AvailablePhoneNumbers/US/TollFree?Contains=STORM'),
          Twilio::AvailablePhoneNumbers.search_toll_free(:contains => 'STORM')
      end
    end
  end
end
