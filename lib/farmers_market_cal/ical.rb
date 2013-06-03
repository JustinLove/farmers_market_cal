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

  module CalendarProperty
    class Calname < Property::Base
      name "X-WR-CALNAME"
      value :types => [:text]
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
      cal.version 2.0
      cal.prodid "-//Justin Love//Farmers Market Cal//EN"
      cal.set_property('calname', "Farmers Market Cal")
      year = today.year
      ical = self
      @events.each do |e|
        next unless e[:season_start]
        cal.event do
          summary e[:title]
          description([e[:comment], e[:products]].join(' '))
          url e[:map]
          location e[:address]

          st = ical.first(year, e[:season_start], e[:day_of_week])
          dtstart DateTime.new(*([year, st.month, st.day] + e[:time_start]))
          dtend DateTime.new(*([year, st.month, st.day] + e[:time_end]))

          un = ical.last(year, e[:season_end], e[:day_of_week]).strftime('%Y%m%d')
          dow = e[:day_of_week][0,2].upcase
          rrule "FREQ=WEEKLY;INTERVAL=1;BYDAY=#{dow};UNTIL=#{un}"
        end
      end

      cal.to_ical
    end

    def today
      Date.today
    end

    def first(year, month, day)
      day = day.downcase + '?'
      date = Date.new(year, month)
      until date.__send__(day)
        date += 1
      end
      date
    end

    def last(year, month, day)
      day = day.downcase + '?'
      date = Date.new(year, month) >> 1
      date -= 1 until date.__send__(day)
      date
    end
  end
end
