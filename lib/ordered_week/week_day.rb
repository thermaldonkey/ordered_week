class OrderedWeek
  class WeekDay
    VALID_DAYS = %i(sunday monday tuesday wednesday thursday friday saturday)

    attr_reader :day

    def self.validate(day)
      new(day).validate
    end

    def initialize(day)
      @day = :"#{day}".downcase
    end

    def validate
      valid? ? day : fail_with_message
    end

    def valid?
      VALID_DAYS.include?(day)
    end

    private

    def fail_with_message
      fail ArgumentError, "#{day.inspect} is not a valid day name. " \
        "Start day should be one of #{VALID_DAYS}."
    end
  end
end
