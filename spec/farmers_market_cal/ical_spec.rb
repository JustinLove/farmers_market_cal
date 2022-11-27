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
          :season_start => Date.new(2013, 6, 6),
          :season_end => Date.new(2013, 10, 3),
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
      allow(ical).to receive(:today).and_return(Date.new(2013, 6, 1))
    end

    it {puts subject}
    it {expect(subject).to match('VCALENDAR')}
    it {expect(subject).to match('VEVENT')}
    it {expect(subject).to match('National Day of Civic Hacking')}
    it {expect(subject).to match('hackforchange')}
    it {expect(subject).to match('United States')}
    it {expect(subject).to match('20130606T090000')}
    it {expect(subject).to match('20131003')}
    it {expect(subject).to match('T140000')}
    it {expect(subject).to_not match('two')}
  end
end
