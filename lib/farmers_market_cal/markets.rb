require 'farmers_market_cal/directory'
require 'farmers_market_cal/schedule'
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
          schedule = Schedule.new(market['Schedule'])
          prop.merge!(schedule.to_hash) if schedule.match
        end

        prop
      end
    end
  end
end
