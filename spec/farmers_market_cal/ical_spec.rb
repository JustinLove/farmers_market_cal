require 'spec_helper'
require 'farmers_market_cal/ical'

module FarmersMarketCal
  describe Ical do
    let(:cut) {Ical}
    let(:events) {
      [
        {
          :title => 'National Day of Civic Hacking',
          :profile => 'http://hackforchange.org/',
          :season_start => [6, 1],
          :season_end => [10, 28],
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
    it {should match('20130601T090000')}
    it {should match('20131028T140000')}
  end
end
