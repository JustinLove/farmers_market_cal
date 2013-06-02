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
        next unless e[:season_start]
        cal.event do
          summary e[:title]
          description e[:products]
          url e[:profile]
          dtstart DateTime.new(*([year] + e[:season_start] + e[:time_start]))
          dtend DateTime.new(*([year] + e[:season_start] + e[:time_end]))
          rrule "FREQ=WEEKLY;INTERVAL=1;BYDAY=#{e[:day_of_week][0,2].upcase};UNTIL=#{Date.new(*([year] + e[:season_end])).strftime('%Y%m%d')}"
        end
      end

      cal.to_ical
    end

    def today
      Date.today
    end
  end
end
