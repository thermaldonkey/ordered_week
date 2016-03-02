require 'spec_helper'

RSpec.describe OrderedWeek do
  let(:default_start_day) { :monday }
  let(:fancy_week) { Class.new(OrderedWeek) }

  describe '::start_day' do
    subject { OrderedWeek.start_day }

    it 'should default to :monday' do
      is_expected.to eq(:monday)
    end

    it 'should be set by default for subclasses' do
      expect(fancy_week.start_day).to eq(default_start_day)
    end
  end

  describe '::start_day=' do
    after(:each) { OrderedWeek.start_day = default_start_day }

    subject { OrderedWeek.start_day = day }

    context 'given a valid day of week' do
      let(:day) { :wednesday }

      it 'should update the established start of week' do
        expect { subject }.to change { OrderedWeek.start_day }
          .from(default_start_day).to(day)

        expect { fancy_week.start_day = day }
          .to change { fancy_week.start_day }
          .from(default_start_day).to(day)
      end

      it 'should not pollute super-classes' do
        expect { fancy_week.start_day = day }
          .not_to change { OrderedWeek.start_day }
      end

      it 'should not pollute sub-classes' do
        expect { subject }.not_to change { fancy_week.start_day }
      end
    end

    context 'given an invalid day of week' do
      let(:day) { :bad }

      it 'should not update the established start of week' do
        expect { subject }.not_to change { OrderedWeek.start_day }
      end

      it 'should not pollute super-classes' do
        expect { fancy_week.start_day = day }
          .not_to change { OrderedWeek.start_day }
      end

      it 'should not pollute sub-classes' do
        expect { subject }.not_to change { fancy_week.start_day }
      end
    end
  end

  describe '::new' do
    it 'should return the week containing the given date' do
      date = Date.today - 10
      week_start = (date - 6..date).find(&:monday?)
      expect(OrderedWeek.new(date).to_a)
        .to eq((week_start...week_start + 7).to_a)
    end

    it 'should return the week containing any date-like object' do
      week_of_seconds = 60 * 60 * 24 * 7
      expect(OrderedWeek.new(Time.now - week_of_seconds).to_a)
        .to eq(OrderedWeek.new(Date.today - 7).to_a)
    end

    it 'should default to the current week, if not given an arg' do
      week_start = (Date.today - 6..Date.today).find(&:monday?)
      expect(OrderedWeek.new.to_a).to eq((week_start...week_start + 7).to_a)
    end

    it 'should accept an optional start day to override the default' do
      expect(OrderedWeek.new(Date.today, :thursday).start_date)
        .to be_thursday
    end

    it 'should use the default start day if the given day is invalid' do
      expect(OrderedWeek.new(Date.today, :bad).start_date)
        .to eq(OrderedWeek.new.start_date)
    end
  end

  describe 'An instance of', OrderedWeek do
    let(:week) { OrderedWeek.new }

    describe '#start_day' do
      it 'should default to the classes start_day' do
        expect(OrderedWeek.new.start_day).to eq(OrderedWeek.start_day)
      end

      it 'should return the given start_day (if any)' do
        expect(OrderedWeek.new(Date.today, :wednesday).start_day)
          .to eq(:wednesday)
      end
    end

    describe '#start_date' do
      subject { week.start_date }

      it 'should return the first date in the week' do
        is_expected.to eq(week.to_a.first)
      end
    end

    describe '#end_date' do
      subject { week.end_date }

      it 'should return the last date in the week' do
        is_expected.to eq(week.to_a.last)
      end
    end

    %i(sunday monday tuesday wednesday thursday friday saturday).each do |day|
      describe "##{day}" do
        subject { week.public_send(day) }

        it "should return the #{day.capitalize} of the given week" do
          is_expected.to eq(week.find(&:"#{day}?"))
        end
      end
    end

    describe '#inspect' do
      subject { week.inspect }

      it 'should inspect the array of dates' do
        is_expected.to eq(week.to_a.map(&:to_s).inspect.gsub('"', ''))
      end
    end

    describe '#to_a' do
      subject { week.to_a }

      it 'should return the array of dates in the week' do
        is_expected.to eq((week.start_date..week.end_date).to_a)
      end
    end

    describe '#each' do
      it 'should delegate to @days' do
        expect(week.each).to be_an(Enumerator)
        expect(week.each.inspect).to eq(week.to_a.each.inspect)
      end

      it 'should make for enumerable operations' do
        enum_return = week.map { |obj| obj.strftime("%F") }
        expect(enum_return).to eq(week.to_a.map(&:to_s))
      end
    end
  end
end
