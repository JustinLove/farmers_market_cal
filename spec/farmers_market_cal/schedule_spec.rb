require 'spec_helper'
require 'farmers_market_cal/schedule'

module FarmersMarketCal
  describe Schedule do
    let(:cut) {Schedule}

    describe 'slash' do
      subject {cut.new('06/06/2013 to 10/03/2013 Thu: 9:00 AM-2:00 PM;<br> <br> <br> ')}
      it {expect(subject.day_of_week).to eq('thursday')}
      it {expect(subject.season_start).to eq(Date.new(2013, 6, 6))}
      it {expect(subject.season_end).to eq(Date.new(2013, 10, 3))}
      it {expect(subject.time_start).to eq([9, 0])}
      it {expect(subject.time_end).to eq([14, 0])}
    end

    describe 'month' do
      subject {cut.new('June - October Thursday 9:00 AM to  2:00 PM')}
      it {expect(subject.day_of_week).to eq('thursday')}
      it {expect(subject.season_start).to eq(Date.new(2022, 6, 2))}
      it {expect(subject.season_end).to eq( Date.new(2022, 10, 27))}
      it {expect(subject.time_start).to eq( [9, 0])}
      it {expect(subject.time_end).to eq( [14, 0])}
    end

    describe 'long' do
      subject {cut.new('June 20, 2012 to Sept 12, 2012 Wed:3:00 PM - 7:00 PM;   ')}
      it {expect(subject.day_of_week).to eq('wednesday')}
      it {expect(subject.season_start).to eq(Date.new(2012, 6, 20))}
      it {expect(subject.season_end).to eq(Date.new(2012, 9, 12))}
      it {expect(subject.time_start).to eq([15, 0])}
      it {expect(subject.time_end).to eq([19, 0])}
    end

    describe 'roselle' do
      subject {cut.new('June to September Sat:8:00 AM - 12:00 PM;   ')}
      it{expect(subject.day_of_week).to eq('saturday')}
      it{expect(subject.season_start).to eq(Date.new(2022, 6, 4))}
      it{expect(subject.season_end).to eq(Date.new(2022, 10, 01))}
      it{expect(subject.time_start).to eq([8, 0])}
      it{expect(subject.time_end).to eq([12, 0])}
    end

    describe 'missing end' do
      subject {cut.new('05/11/2013 to  Sat: 8:00 AM-2:00 PM;<br> <br> <br> ')}
      it{expect(subject.day_of_week).to eq('saturday')}
      it{expect(subject.season_start).to eq(Date.new(2013, 5, 11))}
      it{expect(subject.season_end).to be_nil}
      it{expect(subject.time_start).to eq([8, 0])}
      it{expect(subject.time_end).to eq([14, 0])}
    end

    describe 'no match' do
      subject {cut.new('    ')}
      it{expect(subject.match).to be_nil}
    end
  end
end
