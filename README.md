# Farmers Market Calendar

[http://farmers-market-cal.wondible.com/](http://farmers-market-cal.wondible.com/)

Take data from the [USDA Farmer's Market API](https://search.ams.usda.gov/farmersmarkets/v1/svcdesc.html) and present it as an iCalendar feed.

## Installation

Add this line to your application's Gemfile:

    gem 'farmers_market_cal'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install farmers_market_cal

## Usage

Primarly intended to run as a Heroku application.  The Sinatra application is modular, and the library can also be called directly.

    FarmersMarketCal.zip('60177', 20) # => text of iCalendar

    FarmersMarketCal.at(latitude, longitude, km)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
