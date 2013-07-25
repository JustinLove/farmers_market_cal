require 'spec_helper'
require 'farmers_market_cal/markets'
require 'json'

module FarmersMarketCal
  describe Markets do
    let(:cut) {Markets}
    def search
      @search ||= JSON.parse(File.read('spec/fixtures/zipSearch.json'))['results']
    end
    describe 'current' do
      def details
        @details ||= JSON.parse(File.read('spec/fixtures/mktDetails20130724.json'))['marketdetails']
      end

      def connector
        x = stub('connector')
        x.stub(:at).and_return(search)
        x.stub(:zip).and_return(search)
        x.stub(:find).and_return(details)
        x
      end
      let(:markets) {cut.new(connector)}
      subject {markets}

      it {subject.at(42.16808, -88.428141).should have(20).items}
      it {subject.zip('60177').should have(20).items}

      describe 'item' do
        subject {markets.zip('60177').first}
        it {subject[:id].should == '1002692'}
        it {subject[:title].should == 'Downtown Elgin Harvest Market'}
        it {subject[:map].should == 'http://maps.google.com/?q=42.041325%2C%20-88.287334%20(%22Downtown+Elgin+Harvest+Market%22)'}
        it {subject[:schedule].should == '06/06/2013 to 10/03/2013 Thu: 9:00 AM-2:00 PM;<br> <br> <br> '}
        it {subject[:day_of_week].should == 'Thu'}
        it {subject[:season_start].should == Date.new(2013, 6, 6)}
        it {subject[:season_end].should == Date.new(2013, 10, 3)}
        it {subject[:time_start].should == [9, 0]}
        it {subject[:time_end].should == [14, 0]}
        it {subject[:products].should include('Baked goods')}
      end
    end

    describe '20130601' do
      def details
        @details ||= JSON.parse(File.read('spec/fixtures/mktDetails20130601.json'))['marketdetails']
      end

      def connector
        x = stub('connector')
        x.stub(:at).and_return(search)
        x.stub(:zip).and_return(search)
        x.stub(:find).and_return(details)
        x
      end
      let(:markets) {cut.new(connector)}
      subject {markets}

      it {subject.at(42.16808, -88.428141).should have(20).items}
      it {subject.zip('60177').should have(20).items}

      describe 'item' do
        subject {markets.zip('60177').first}
        it {subject[:id].should == '1002692'}
        it {subject[:title].should == 'Downtown Elgin Harvest Market'}
        it {subject[:map].should == 'http://maps.google.com/?q=42.041325%2C%20-88.287334%20(%22Downtown+Elgin+Harvest+Market%22)'}
        it {subject[:schedule].should == 'June - October Thursday 9:00 AM to  2:00 PM'}
        it {subject[:day_of_week].should == 'Thursday'}
        it {subject[:season_start].should == Date.new(2013, 6, 6)}
        it {subject[:season_end].should == Date.new(2013, 10, 31)}
        it {subject[:time_start].should == [9, 0]}
        it {subject[:time_end].should == [14, 0]}
        it {subject[:products].should == 'Baked goods; Cheese and/or dairy products; Crafts and/or woodworking items; Cut flowers; Eggs; Fresh fruit and vegetables; Fresh and/or dried herbs; Honey; Canned or preserved fruits, vegetables, jams, jellies, preserves, salsas, pickles, dried fruit, etc.; Meat; Plants in containers; Poultry; Prepared foods (for immediate consumption); Soap and/or body care products; Olives, Spices, Concessions'}
      end
    end
  end
end
