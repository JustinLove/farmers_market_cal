require 'date'

module FarmersMarketCal
  class Schedule
    def initialize(schedule)
      @match,raw_season_start,sepd,raw_season_end,dow,raw_time_start,period_start,sept,raw_time_end,period_end =
        *schedule
          .match(/([\w\/]+|\w+ \d+, \d+) (to|-) ([\w\/]+|\w+ \d+, \d+)? (\w+):? ?(\d?\d:\d\d) (.M) ?(to|-) ? ?(\d?\d:\d\d) (.M)/)
      return unless @match
      @comment = *schedule.match(/\(.*\)/)
      @day_of_week = parse_dow(dow)
      @season_start = parse_date(raw_season_start, :start)
      @season_end = parse_date(raw_season_end, :end) if raw_season_end
      @time_start = parse_time(raw_time_start, period_start)
      @time_end = parse_time(raw_time_end, period_end)
    end

    ATTRIBUTES = [
      :season_start,
      :season_end,
      :day_of_week,
      :time_start,
      :time_end,
      :comment,
    ]

    attr_reader :match
    attr_reader *ATTRIBUTES

    def to_hash
      Hash[ATTRIBUTES.map {|a| [a, __send__(a)]}]
    end

    def parse_date(d, which)
      if d.match('/')
        Date.strptime(d, '%m/%d/%Y')
      elsif d.match(',')
        Date.parse(d)
      elsif which == :start
        first(Date.parse(d))
      elsif which == :end
        last(Date.parse(d))
      end
    end

    def parse_time(t, period)
      parts = t.split(':').map(&:to_i)
      parts[0] += 12 if (period == 'PM') ^ (parts[0] == 12)
      parts
    end

    def first(date)
      day = day_of_week + '?'
      until date.__send__(day)
        date += 1
      end
      date
    end

    def last(date)
      day = day_of_week + '?'
      date >>= 1
      date -= 1 until date.__send__(day)
      date
    end

    def parse_dow(dow)
      dow.downcase!
      DOW.each do |day|
        return day if day.start_with?(dow)
      end
      dow
    end

    DOW = [
      'monday',
      'tuesday',
      'wednesday',
      'thursday',
      'friday',
      'saturday',
    ]
  end
end
