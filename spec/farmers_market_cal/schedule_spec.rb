require 'spec_helper'
require 'farmers_market_cal/schedule'

module FarmersMarketCal
  describe Schedule do
    let(:cut) {Schedule}

    describe 'slash' do
      subject {cut.new('06/06/2013 to 10/03/2013 Thu: 9:00 AM-2:00 PM;<br> <br> <br> ')}
      it {subject.day_of_week.should == 'thursday'}
      it {subject.season_start.should == Date.new(2013, 6, 6)}
      it {subject.season_end.should == Date.new(2013, 10, 3)}
      it {subject.time_start.should == [9, 0]}
      it {subject.time_end.should == [14, 0]}
    end

    describe 'month' do
      subject {cut.new('June - October Thursday 9:00 AM to  2:00 PM')}
      it {subject.day_of_week.should == 'thursday'}
      it {subject.season_start.should == Date.new(2013, 6, 6)}
      it {subject.season_end.should == Date.new(2013, 10, 31)}
      it {subject.time_start.should == [9, 0]}
      it {subject.time_end.should == [14, 0]}
    end

    describe 'long' do
      subject {cut.new('June 20, 2012 to Sept 12, 2012 Wed:3:00 PM - 7:00 PM;   ')}
      it {subject.day_of_week.should == 'wednesday'}
      it {subject.season_start.should == Date.new(2012, 6, 20)}
      it {subject.season_end.should == Date.new(2012, 9, 12)}
      it {subject.time_start.should == [15, 0]}
      it {subject.time_end.should == [19, 0]}
    end

    describe 'roselle' do
      subject {cut.new('June to September Sat:8:00 AM - 12:00 PM;   ')}
      it {subject.day_of_week.should == 'saturday'}
      it {subject.season_start.should == Date.new(2013, 6, 1)}
      it {subject.season_end.should == Date.new(2013, 9, 28)}
      it {subject.time_start.should == [8, 0]}
      it {subject.time_end.should == [12, 0]}
    end

    describe 'missing end' do
      subject {cut.new('05/11/2013 to  Sat: 8:00 AM-2:00 PM;<br> <br> <br> ')}
      it {subject.day_of_week.should == 'saturday'}
      it {subject.season_start.should == Date.new(2013, 5, 11)}
      it {subject.season_end.should be_nil}
      it {subject.time_start.should == [8, 0]}
      it {subject.time_end.should == [14, 0]}
    end

    describe 'no match' do
      subject {cut.new('    ')}
      it {subject.match.should be_nil}
    end
  end
end
