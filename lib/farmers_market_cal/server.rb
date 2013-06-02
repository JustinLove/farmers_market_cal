require 'sinatra/base'
require 'farmers_market_cal'

module FarmersMarketCal
  class Server < Sinatra::Base
    configure do 
      mime_type :ics, 'text/calendar'
    end

    get '/farmers_markets.ics' do
      content_type :ics
      if params[:zip]
        FarmersMarketCal.zip(zip, km)
      elsif params[:ll]
        lat, lng = *(params[:ll].split(','))
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
      params[:zip]
    end

    def km
      params[:km] && params[:km].to_f
    end
  end
end

