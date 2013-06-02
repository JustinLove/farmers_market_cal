require "farmers_market_cal/version"
require "farmers_market_cal/markets"
require "farmers_market_cal/ical"

module FarmersMarketCal
  extend self

  def zip(code)
    Ical.new(Markets.new.zip(code)).to_s
  end

  def at(latitude, longitude)
    Ical.new(Markets.new.at(latitude, longitude)).to_s
  end
end
