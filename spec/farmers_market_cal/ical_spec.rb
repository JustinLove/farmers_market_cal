require 'spec_helper'
require 'farmers_market_cal/ical'

module FarmersMarketCal
  describe Ical do
    let(:cut) {Ical}
    let(:events) {
      [
        {
          :title => 'National Day of Civic Hacking',
          :map => 'http://hackforchange.org/',
          :address => 'United States',
          :season_start => 6,
          :season_end => 10,
          :day_of_week => 'Thursday',
          :time_start => [9, 0],
          :time_end => [14, 0],
        },
        {
          :title => 'two',
          :profile => 'twolink',
        },
      ]
    }
    let(:ical) {cut.new(events).to_s}

    subject {ical}

    before do
      ical.stub(:today).and_return(Date.new(2013, 6, 1))
    end

    it {puts subject}
    it {should match('VCALENDAR')}
    it {should match('VEVENT')}
    it {should match('National Day of Civic Hacking')}
    it {should match('hackforchange')}
    it {should match('United States')}
    it {should match('20130606T090000')}
    it {should match('20131031')}
    it {should match('T140000')}
    it {should_not match('two')}
  end
end
