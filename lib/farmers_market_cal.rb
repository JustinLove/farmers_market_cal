require "farmers_market_cal/version"
require "farmers_market_cal/markets"
require "farmers_market_cal/ical"

module FarmersMarketCal
  extend self

  def zip(code, km = 20)
    Ical.new(Markets.new.zip(code, km)).to_s
  end

  def at(latitude, longitude, km = 20)
    Ical.new(Markets.new.at(latitude, longitude, km)).to_s
  end
end
