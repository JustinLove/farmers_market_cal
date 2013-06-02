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
      FarmersMarketCal.at(lat.to_f, lng.to_f, params[:km].to_f)
    end

    get '/zip.ics' do
      content_type :ics
      FarmersMarketCal.zip(params[:zip], params[:km].to_f)
    end

    get '/:zip.ics' do
      content_type :ics
      FarmersMarketCal.zip(params[:zip], params[:km].to_f)
    end
  end
end

