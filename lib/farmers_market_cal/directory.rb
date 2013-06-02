require 'json'
require 'open-uri'

module FarmersMarketCal
  class Directory
    URL = 'http://search.ams.usda.gov/FarmersMarkets/v1/data.svc'

    def at(lat, lng)
      consume {get(URL+"/locSearch?lat=#{lat}&lng=#{lng}")}
    end

    def zip(zip)
      consume {get(URL+"/zipSearch?zip=#{zip}")}
    end

    def find(id)
      consume {get(URL+"/mktDetail?id=#{id}")}
    end

    def get(url)
      open(url).read
    end

    def consume
      JSON.parse(yield)
    end
  end
end
