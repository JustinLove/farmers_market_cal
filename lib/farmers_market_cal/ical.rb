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
      @events.each do |e|
        cal.event do
          summary e[:title]
          url e[:link]
          dtstart(e[:time_start] || e[:date])
          dtend(e[:time_end] || e[:date])
        end
      end

      cal.to_ical
    end
  end
end
