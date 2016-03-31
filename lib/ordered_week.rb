require 'date'

require 'ordered_week/week_day'

class OrderedWeek
  include Enumerable

  VERSION = '0.1.0'
  DEFAULT_START_DAY = :monday

  @start_day = DEFAULT_START_DAY

  attr_reader :start_day
  alias to_ary to_a

  private_constant :WeekDay
  private_constant :DEFAULT_START_DAY

  def self.start_day
    @start_day
  end

  def self.start_day= day
    @start_day = WeekDay.validate(day)
  end

  def initialize(includes_date = Date.today, start_day = self.class.start_day)
    @start_day = WeekDay.validate(start_day)
    @days = build_days(validate_includes_date(includes_date))
  end

  def inspect
    @days.map {|d| d.strftime("%F")}.inspect.gsub('"','')
  end

  def to_range
    start_date..end_date
  end

  def to_h
    Hash[WeekDay::VALID_DAYS.zip(@days.rotate(-start_day_index))]
  end

  def each(&block)
    @days.each(&block)
  end

  def start_date
    @days.first
  end

  def end_date
    @days.last
  end

  WeekDay::VALID_DAYS.each_with_index do |day, day_index|
    define_method(day) { @days[day_index - start_day_index] }
  end

  private

    def self.inherited(base)
      base.start_day = DEFAULT_START_DAY
    end

    def validate_includes_date(date)
      if date.respond_to?(:to_date)
        date.to_date
      else
        fail ArgumentError, "#{date.inspect} is not a valid date. " \
          'Please pass an object which responds to #to_date.'
      end
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
      WeekDay::VALID_DAYS.index(start_day)
    end
end
