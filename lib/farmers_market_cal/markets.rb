require 'farmers_market_cal/directory'
require 'date'

module FarmersMarketCal
  class Markets
    def initialize(connector = Directory.new)
      @connector = connector
    end

    attr_accessor :connector

    def at(latitude, longitude, km = 20)
      process connector.at(latitude, longitude, km)
    end

    def zip(zip, km = 20)
      process connector.zip(zip, km)
    end

    def process(results)
      results.map do |i|
        id = i['id']
        market = connector.find(id)
        prop = {
          :id => id,
          :title => i['marketname'].split(' ').drop(1).join(' '),
          :distance_in_miles => i['marketname'].split(' ').first.to_f,
          :address => market['Address'],
          :map => market['GoogleLink'],
          :schedule => market['Schedule'],
          :products => market['Products'],
        }

        if market['Schedule'] && !market['Schedule'].empty?
          match,season_start,season_end,dow,time_start,period_start,time_end,period_end = *market['Schedule'].gsub(/\s+/, ' ').match(/(\w+) - (\w+) (\w+) (\d\d?:\d\d) (.M) to (\d\d?:\d\d) (.M)/)
          next prop unless match
          comment = *market['Schedule'].match(/\(.*\)/)
          prop.merge!({
            :season_start => Date.parse(season_start).month,
            :season_end => Date.parse(season_end).month,
            :day_of_week => dow,
            :time_start => parse_time(time_start, period_start),
            :time_end => parse_time(time_end, period_end),
            :comment => comment,
          })
        end

        prop
      end
    end

    def parse_time(t, period)
      parts = t.split(':').map(&:to_i)
      parts[0] += 12 if period == 'PM'
      parts
    end
  end
end
