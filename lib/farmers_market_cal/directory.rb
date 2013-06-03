require 'json'
require 'open-uri'
require 'redis'

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
      @url = url # debugging
      cache(url) do
        open(url).read
      end
    end

    def consume(km = nil)
      text = yield
      response = JSON.parse(text.gsub(/},\s*]/, '}]'))
      if response.include?('marketdetails')
        response['marketdetails']
      else
        restrict(response['results'], km)
      end
    rescue JSON::ParserError => e
      puts "exception processing #{@url}" if @url
      p e
      []
    end

    def restrict(results, km)
      miles = (km || 20) / 1.609344
      results.select do |market|
        market['marketname'].split(' ').first.to_f < miles
      end
    end

    def cache(key)
      return yield unless redis

      cached = redis.get key
      return cached if cached

      response = yield
      redis.setex key, (60*60*24*7), response
      response
    end

    def redis
      url = ENV['REDIS_URL'] || ENV['REDISTOGO_URL']
      if url
        @redis ||= Redis.new(:url => url)
      end
    end
  end
end
