module Twilio
  # An AvailablePhoneNumbers resources represents the available phone numbers
  # that Twilio can provide you based on your search criteria. The valid 
  # query terms are outlined in the search methods.
  # Example:
  #   Twilio.connect('my_twilio_sid', 'my_auth_token')
  #   Twilio.AvailablePhoneNumbers.search_local(:area_code => 541)
  class AvailablePhoneNumbers < TwilioObject

    # The Search method handles the searching of both local and toll-free 
    # numbers. 
    def search(opts={})
      iso_country_code = opts[:iso_country_code] || 'US'
      resource = opts[:resource]
      Twilio.get("/AvailablePhoneNumbers/#{iso_country_code}/#{resource}", 
        :query => {
          :AreaCode => opts[:area_code],
          :InPostalCode => opts[:postal_code],
          :InRegion => opts[:in_region],
          :Contains => opts[:contains],
          :NearLatLong => opts[:near_lat_long],
          :NearNumber => opts[:near_number],
          :InLata => opts[:in_lata],
          :InRateCenter => opts[:in_rate_center],
          :Distance => opts[:distance]
        }.reject {|k,v| v == nil})
    end

    # The search_local method searches for numbers in local areas (i.e. state, zip, etc..)
    # Search Options:
    #   :area_code
    #   :postal_code
    #   :in_region
    #   :contains
    #   :near_lat_long
    #   :near_number
    #   :in_lata
    #   :in_rate_center
    #   :distance
    def search_local(opts ={})
      opts = {:resource => 'Local'}.merge(opts)
      search(opts)
    end

    # The search_toll_free method searches for available toll-free numbers
    # Search Options
    #   :contains
    def search_toll_free(opts ={})
      opts = {:resource => 'TollFree'}.merge(opts)
      search(opts)
    end
  end
end

