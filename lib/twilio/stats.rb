module Twilio
  # Stats class creates a non-standard meta-api to provide simple roll-up
  # statistics for current account usage
  class Stats < TwilioObject
    # Returns a hash with aggregate count, duration, and price
    # statistics for each "from" phone number, as well as a total
    # across all numbers. -- Makes most sense for outbound apps
    # TODO refactor this
    def calls(options = {})
      options = {:PageSize => 1000}.merge(options)
      stats = {}
      page = 0
      numpages = -1
      while page != numpages do
        resp = Twilio::Call.list(options.merge({:page => page})).parsed_response['TwilioResponse']['Calls']
        page = resp['page'].to_i + 1
        numpages = resp['numpages'].to_i
        resp['Call'].each do |call|
          from_phone_num = call['From']
          unless stats[from_phone_num] 
            stats[from_phone_num] = {}
            stats[from_phone_num][:count] = 0
            stats[from_phone_num][:duration] = 0
            stats[from_phone_num][:minutes_charged] = 0
            stats[from_phone_num][:price] = 0
          end
          stats[from_phone_num][:count] += 1 unless call['ParentCallSid']
          stats[from_phone_num][:duration] += call['Duration'].to_i
          stats[from_phone_num][:minutes_charged] += (call['Duration'].to_i / 60.0).ceil
          stats[from_phone_num][:price] += (call['Price'].to_f * 100).to_i
        end
      end
      
      total_count = 0
      total_duration = 0
      total_minutes_charged = 0
      total_price = 0
      stats.each do |num, info|
        total_count += info[:count]
        total_duration += info[:duration]
        total_minutes_charged += info[:minutes_charged]
        total_price += info[:price]
      end
      stats[:total_count] = total_count
      stats[:total_duration] = total_duration
      stats[:total_minutes_charged] = total_minutes_charged
      stats[:total_price] = total_price

      stats
    end
  end
end

