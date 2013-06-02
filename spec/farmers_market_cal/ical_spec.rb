require 'spec_helper'
require 'farmers_market_cal/ical'

module FarmersMarketCal
  describe Ical do
    let(:cut) {Ical}
    let(:events) {
      [
        {
          :title => 'National Day of Civic Hacking',
          :link => 'http://hackforchange.org/',
          :date => Date.new(2013, 6, 1),
          :all_day => true,
        },
        {
          :title => 'two',
          :link => 'twolink',
          :date => Date.new(2013, 6, 1),
          :time_start => DateTime.new(2013, 6, 1, 17, 0),
          :time_end => DateTime.new(2013, 6, 1, 19, 0),
        },
      ]
    }
    let(:ical) {cut.new(events).to_s}

    subject {ical}

    it {puts subject}
    it {should match('VCALENDAR')}
    it {should match('VEVENT')}
    it {should match('National Day of Civic Hacking')}
    it {should match('hackforchange')}
    it {should match('20130601T170000')}
    it {should match('20130601T190000')}
  end
end
