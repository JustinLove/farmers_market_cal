require 'spec_helper'
require 'farmers_market_cal/directory'

module FarmersMarketCal
  describe Directory do
    let(:cut) {Directory}
    def search
      @search ||= File.read('spec/fixtures/zipSearch.json')
    end
    def details
      @details ||= File.read('spec/fixtures/mktDetails20130724.json')
    end
    def trailing_comma
      @trailing_comma ||= File.read('spec/fixtures/trailing-comma.json')
    end
    let(:directory) {cut.new}
    subject {directory}

    describe 'consume' do
      it {expect(subject.consume(100) {search}.length).to eq(20)}
      it {expect(subject.consume {details}).to include('Address')}
      it {expect(subject.consume(100) {trailing_comma}.length).to eq(12)}
      it {expect(subject.consume {raise JSON::ParserError}.length).to eq(0)}
    end

    describe 'stubbed' do
      describe 'search' do
        before do
          allow(directory).to receive(:get).and_return(search)
        end
        it {expect(subject.zip('60177', 100).length).to eq(20)}
        it {expect(subject.zip('60177', 20).length).to be <= 19}
        it {expect(subject.at(42.16808, -88.428141, 100).length).to eq(20)}
      end

      describe 'find' do
        before do
          allow(directory).to receive(:get).and_return(details)
        end
        it {expect(subject.find('1002692')).to include('Address')}
      end
    end

    describe 'live', :online => true do
      it {expect(subject.zip('60177').length).to be >= 2}
      it {expect(subject.at(42.16808, -88.428141).length).to be >= 5}
      it {expect(subject.find('1002692')).to include('Address')}
    end
  end
end
