require "bundler/gem_tasks"

task :zip, [:zip] do |t,args|
  require 'farmers_market_cal'
  File.write(args[:zip]+'.ics', FarmersMarketCal.zip(args[:zip]))
end

task :at, [:latitude, :longitude] do |t,args|
  require 'farmers_market_cal'
  File.write('at.ics', FarmersMarketCal.at(args[:latitude], args[:longitude]))
end
