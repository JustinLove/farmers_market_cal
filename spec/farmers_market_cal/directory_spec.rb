require 'spec_helper'
require 'farmers_market_cal/directory'

module FarmersMarketCal
  describe Directory do
    let(:cut) {Directory}
    def search
      @search ||= File.read('spec/fixtures/zipSearch.json')
    end
    def details
      @details ||= File.read('spec/fixtures/mktDetails.json')
    end
    let(:directory) {cut.new}
    subject {directory}

    describe 'stubbed' do
      describe 'search' do
        before do
          directory.stub(:get).and_return(search)
        end
        it {subject.zip('60177', 100).should have(20).items}
        it {subject.zip('60177', 20).should have_at_most(19).items}
        it {subject.at(42.16808, -88.428141, 100).should have(20).items}
      end

      describe 'find' do
        before do
          directory.stub(:get).and_return(details)
        end
        it {subject.find('1002692').should include('Address')}
      end
    end

    describe 'live', :online => true do
      it {subject.zip('60177').should have_at_least(10).items}
      it {subject.at(42.16808, -88.428141).should have_at_least(10).items}
      it {subject.find('1002692').should include('Address')}
    end
  end
end
