require 'sinatra/base'
require 'farmers_market_cal'

module FarmersMarketCal
  class Server < Sinatra::Base
    configure do 
      mime_type :ics, 'text/calendar'
    end

    get '/' do
      erb :index
    end

    get '/farmers_markets.ics' do
      content_type :ics
      p zip
      if zip
        FarmersMarketCal.zip(zip, km)
      elsif ll
        lat, lng = *(ll.split(','))
        FarmersMarketCal.at(lat.to_f, lng.to_f, km)
      else
        pass
      end
    end

    get '/farmers_markets/:zip.ics' do
      content_type :ics
      FarmersMarketCal.zip(zip, km)
    end

    def zip
      params[:zip] && !params[:zip].empty? && params[:zip]
    end

    def ll
      params[:ll] && !params[:ll].empty? && params[:ll]
    end

    def km
      params[:km] && !params[:km].empty? && params[:km].to_f
    end

    def ics_url
      request.url.sub('?', 'farmers_markets.ics?')
    end
  end
end

