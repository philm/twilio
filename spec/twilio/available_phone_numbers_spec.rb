require 'spec_helper'

describe "Available Phone Numbers" do  
  before(:all) do
    Twilio.connect('mysid', 'mytoken')
  end
    
  context "Local Number" do
    it "is searchable" do      
      response, url = stub_get(:available_phone_numbers_local, 'AvailablePhoneNumbers/US/Local')
      
      Twilio::AvailablePhoneNumbers.search_local.should == response
      WebMock.should have_requested(:get, url)
    end
    
    it "is searchable by area code" do      
      response, url = stub_get(:available_phone_numbers_local_search, 'AvailablePhoneNumbers/US/Local?AreaCode=510')
      
      Twilio::AvailablePhoneNumbers.search_local(:area_code => 510).should == response
      WebMock.should have_requested(:get, url)
    end
    
    it "is searchable by postal code" do      
      response, url = stub_get(:available_phone_numbers_local_search, 'AvailablePhoneNumbers/US/Local?InPostalCode=94612')
      
      Twilio::AvailablePhoneNumbers.search_local(:postal_code => 94612).should == response
      WebMock.should have_requested(:get, url)
    end
    
    it "is searchable using multiple parameters" do      
      response, url = stub_get(:available_phone_numbers_local_search, 'AvailablePhoneNumbers/US/Local?Contains=510555****&Distance=50&InLata=722&InRateCenter=OKLD0349T&InRegion=CA&NearLatLong=37.806940%252C-122.270360&NearNumber=15105551213')
      
      Twilio::AvailablePhoneNumbers.search_local(:in_region => 'CA', :contains => '510555****', :near_lat_long => '37.806940,-122.270360', :near_number => '15105551213', :in_lata => 722, :in_rate_center => 'OKLD0349T', :distance => 50).should == response
      WebMock.should have_requested(:get, url)
    end
  end

  context "Toll-free Number" do
    it "is searchable" do      
      response, url = stub_get(:available_phone_numbers_toll_free, 'AvailablePhoneNumbers/US/TollFree')
      
      Twilio::AvailablePhoneNumbers.search_toll_free.should == response
      WebMock.should have_requested(:get, url)
    end
    
    it "is searchable as a vanity number" do      
      response, url = stub_get(:available_phone_numbers_toll_free_search, 'AvailablePhoneNumbers/US/TollFree?Contains=STORM')
      
      Twilio::AvailablePhoneNumbers.search_toll_free(:contains => 'STORM').should == response
      WebMock.should have_requested(:get, url)
    end
  end
end
