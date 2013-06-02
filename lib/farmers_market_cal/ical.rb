require 'icalendar2'

module Icalendar2
  module Property
    class Url < Base
      name "URL"
      value :types => [:text]
    end

    class Dtend < Base
      name "DTEND"
      # main code gets these backwards
      value :types => [:date_time, :date]
   end
 end
end

module FarmersMarketCal
  class Ical
    def initialize(events)
      @events = events
    end

    def to_s
      cal = Icalendar2::Calendar.new
      year = today.year
      @events.each do |e|
        cal.event do
          summary e[:title]
          description e[:products]
          url e[:profile]
          if e[:season_start]
            dtstart DateTime.new(*([year] + e[:season_start] + e[:time_start]))
            dtend DateTime.new(*([year] + e[:season_end] + e[:time_end]))
          end
        end
      end

      cal.to_ical
    end

    def today
      Date.today
    end
  end
end
