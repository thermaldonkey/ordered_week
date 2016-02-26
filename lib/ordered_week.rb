require 'date'

class OrderedWeek
  include Enumerable

  VERSION = '0.0.1'
  WEEK_DAYS = [:sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday]

  @@start_day ||= :monday

  attr_reader :start_day

  private_constant :WEEK_DAYS

  def self.start_day
    @@start_day
  end

  def self.start_day= day
    return false unless WEEK_DAYS.include?(day)
    @@start_day = day
  end

  def initialize includes_date = nil, start_day = nil
    @start_day = default_start_day(start_day)
    @days = build_days(default_date(includes_date))
  end

  def inspect
    @days.map {|d| d.strftime("%F")}.inspect.gsub('"','')
  end

  def to_a
    @days
  end

  def each &block
    @days.each {|d| yield d}
  end

  def start_date
    @days.first
  end

  def end_date
    @days.last
  end

  WEEK_DAYS.each_with_index do |day, day_index|
    define_method day do
      @days[ day_index - start_day_index ]
    end
  end

  private

    def default_start_day(day)
      WEEK_DAYS.include?(day) ? day : @@start_day
    end

    def default_date(date)
      date.respond_to?(:to_date) ? date.to_date : Date.today
    end

    def build_days(date)
      while not date_is_start_of_week(date)
        date -= 1
      end
      (date..date+6).to_a
    end

    def date_is_start_of_week date
      date.send("#{start_day}?")
    end

    def start_day_index
      WEEK_DAYS.index(start_day)
    end
end
