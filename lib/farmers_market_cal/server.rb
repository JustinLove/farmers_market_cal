require 'sinatra/base'
require 'farmers_market_cal'

module FarmersMarketCal
  class Server < Sinatra::Base
    configure do 
      mime_type :ics, 'text/calendar'
    end

    get '/at.ics' do
      content_type :ics
      lat, lng = *(params[:ll].split(','))
      FarmersMarketCal.at(lat.to_f, lng.to_f, km)
    end

    get '/zip.ics' do
      zip_ics
    end

    get '/:zip.ics' do
      zip_ics
    end

    def zip_ics
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

