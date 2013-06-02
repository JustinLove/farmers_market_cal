require 'json'
require 'open-uri'

module FarmersMarketCal
  class Directory
    URL = 'http://search.ams.usda.gov/FarmersMarkets/v1/data.svc'

    def at(lat, lng, km = 20)
      consume(km) {get(URL+"/locSearch?lat=#{lat}&lng=#{lng}")}
    end

    def zip(zip, km = 20)
      consume(km) {get(URL+"/zipSearch?zip=#{zip}")}
    end

    def find(id)
      consume {get(URL+"/mktDetail?id=#{id}")}
    end

    def get(url)
      open(url).read
    end

    def consume(km = nil)
      response = JSON.parse(yield)
      if response.include?('marketdetails')
        response['marketdetails']
      else
        restrict(response['results'], km)
      end
    end

    def restrict(results, km)
      miles = (km || 20) / 1.609344
      results.select do |market|
        market['marketname'].split(' ').first.to_f < miles
      end
    end
  end
end
