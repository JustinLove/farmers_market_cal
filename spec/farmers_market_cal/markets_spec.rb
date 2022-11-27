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
        x = double('connector')
        allow(x).to receive(:at).and_return(search)
        allow(x).to receive(:zip).and_return(search)
        allow(x).to receive(:find).and_return(details)
        x
      end
      let(:markets) {cut.new(connector)}
      subject {markets}

      it{expect(subject.at(42.16808, -88.428141).length).to eq(20)}
      it{expect(subject.zip('60177').length).to eq(20)}

      describe 'item' do
        subject {markets.zip('60177').first}
        it{expect(subject[:id]).to eq('1002692')}
        it{expect(subject[:title]).to eq('Downtown Elgin Harvest Market')}
        it{expect(subject[:map]).to eq('http://maps.google.com/?q=42.041325%2C%20-88.287334%20(%22Downtown+Elgin+Harvest+Market%22)')}
        it{expect(subject[:schedule]).to eq('06/06/2013 to 10/03/2013 Thu: 9:00 AM-2:00 PM;<br> <br> <br> ')}
        it{expect(subject[:day_of_week]).to eq('thursday')}
        it{expect(subject[:season_start]).to eq(Date.new(2013, 6, 6))}
        it{expect(subject[:season_end]).to eq(Date.new(2013, 10, 3))}
        it{expect(subject[:time_start]).to eq([9, 0])}
        it{expect(subject[:time_end]).to eq([14, 0])}
        it{expect(subject[:products]).to include('Baked goods')}
      end
    end

    describe '20130601' do
      def details
        @details ||= JSON.parse(File.read('spec/fixtures/mktDetails20130601.json'))['marketdetails']
      end

      def connector
        x = double('connector')
        allow(x).to receive(:at).and_return(search)
        allow(x).to receive(:zip).and_return(search)
        allow(x).to receive(:find).and_return(details)
        x
      end
      let(:markets) {cut.new(connector)}
      subject {markets}

      it{expect(subject.at(42.16808, -88.428141).length).to eq(20)}
      it{expect(subject.zip('60177').length).to eq(20)}

      describe 'item' do
        subject {markets.zip('60177').first}
        it{expect(subject[:id]).to eq('1002692')}
        it{expect(subject[:title]).to eq('Downtown Elgin Harvest Market')}
        it{expect(subject[:map]).to eq('http://maps.google.com/?q=42.041325%2C%20-88.287334%20(%22Downtown+Elgin+Harvest+Market%22)')}
        it{expect(subject[:schedule]).to eq('June - October Thursday 9:00 AM to  2:00 PM')}
        it{expect(subject[:day_of_week]).to eq('thursday')}
        it{expect(subject[:season_start]).to eq(Date.new(2022, 6, 2))}
        it{expect(subject[:season_end]).to eq(Date.new(2022, 10, 27))}
        it{expect(subject[:time_start]).to eq([9, 0])}
        it{expect(subject[:time_end]).to eq([14, 0])}
        it{expect(subject[:products]).to eq('Baked goods; Cheese and/or dairy products; Crafts and/or woodworking items; Cut flowers; Eggs; Fresh fruit and vegetables; Fresh and/or dried herbs; Honey; Canned or preserved fruits, vegetables, jams, jellies, preserves, salsas, pickles, dried fruit, etc.; Meat; Plants in containers; Poultry; Prepared foods (for immediate consumption); Soap and/or body care products; Olives, Spices, Concessions')}
      end
    end
  end
end
