require 'spec_helper'

describe OrderedWeek do
  let(:default_start_day) { :monday }
  let(:fancy_week) { Class.new(OrderedWeek) }

  describe "::start_day" do
    subject { OrderedWeek.start_day }

    it "should respond" do
      expect{ subject }.to_not raise_error
    end

    it "should return a Symbol" do
      subject.should be_a Symbol
    end

    it 'should be set by default for subclasses' do
      expect(fancy_week.start_day).to eq(default_start_day)
    end
  end

  describe "::start_day=" do
    after(:each) { OrderedWeek.start_day = default_start_day }

    subject { OrderedWeek.start_day = :sunday }

    it "should respond" do
      expect{ subject }.to_not raise_error
    end

    context "given a valid day of week" do
      let(:day) { :wednesday }

      subject { OrderedWeek.start_day = day }

      it "should update the established start of week" do
        OrderedWeek.start_day.should_not eq day
        subject
        OrderedWeek.start_day.should eq day
      end

      it 'should not pollute super-classes' do
        expect { fancy_week.start_day = day }
          .not_to change { OrderedWeek.start_day }
      end

      it 'should not pollute sub-classes' do
        expect { subject }
          .not_to change { fancy_week.start_day }
      end
    end

    context "given an invalid day of week" do
      let(:day) { :bad }

      subject { OrderedWeek.start_day = day }

      it "should not update the established start of week" do
        OrderedWeek.start_day.should_not eq day
        subject
        OrderedWeek.start_day.should_not eq day
      end

      it 'should not pollute super-classes' do
        expect { fancy_week.start_day = day }
          .not_to change { OrderedWeek.start_day }
      end

      it 'should not pollute sub-classes' do
        expect { subject }
          .not_to change { fancy_week.start_day }
      end
    end
  end

  describe "::new" do
    subject { OrderedWeek.new }

    it "should respond" do
      expect{ subject }.to_not raise_error
    end

    it "should accept a Date" do
      expect{ OrderedWeek.new(Date.today) }.to_not raise_error
    end

    it "should accept any date-like object" do
      expect { OrderedWeek.new(Time.now) }.to_not raise_error
    end

    it "should return the week containing any date-like object" do
      week_of_seconds = 60 * 60 * 24 * 7
      expect(OrderedWeek.new(Time.now - week_of_seconds).start_date)
        .to eq(OrderedWeek.new(Date.today - 7).start_date)
    end

    it "should default to the current week, if not given an arg" do
      with_arg = OrderedWeek.new(Date.today)
      without_arg = OrderedWeek.new
      with_arg.start_date.should eq without_arg.start_date
      with_arg.end_date.should eq without_arg.end_date
    end
  end

  describe "An instance of", OrderedWeek do
    subject { OrderedWeek.new }

    describe "#start_date" do
      subject { OrderedWeek.new.start_date }

      it "should respond" do
        expect{ subject }.to_not raise_error
      end

      it "should return a Date" do
        subject.should be_a Date
      end
    end

    describe "#end_date" do
      subject { OrderedWeek.new.end_date }

      it "should respond" do
        expect{ subject }.to_not raise_error
      end

      it "should return a Date" do
        subject.should be_a Date
      end
    end

    describe "#sunday" do
      subject { OrderedWeek.new.sunday }

      it "should respond" do
        expect{ subject }.to_not raise_error
      end

      it "should return a Date" do
        subject.should be_a Date
      end
    end

    describe "#monday" do
      subject { OrderedWeek.new.monday }

      it "should respond" do
        expect{ subject }.to_not raise_error
      end

      it "should return a Date" do
        subject.should be_a Date
      end
    end

    describe "#tuesday" do
      subject { OrderedWeek.new.tuesday }

      it "should respond" do
        expect{ subject }.to_not raise_error
      end

      it "should return a Date" do
        subject.should be_a Date
      end
    end

    describe "#wednesday" do
      subject { OrderedWeek.new.wednesday }

      it "should respond" do
        expect{ subject }.to_not raise_error
      end

      it "should return a Date" do
        subject.should be_a Date
      end
    end

    describe "#thursday" do
      subject { OrderedWeek.new.thursday }

      it "should respond" do
        expect{ subject }.to_not raise_error
      end

      it "should return a Date" do
        subject.should be_a Date
      end
    end

    describe "#friday" do
      subject { OrderedWeek.new.friday }

      it "should respond" do
        expect{ subject }.to_not raise_error
      end

      it "should return a Date" do
        subject.should be_a Date
      end
    end

    describe "#saturday" do
      subject { OrderedWeek.new.saturday }

      it "should respond" do
        expect{ subject }.to_not raise_error
      end

      it "should return a Date" do
        subject.should be_a Date
      end
    end

    describe "#inspect" do
      subject { OrderedWeek.new.inspect }

      it "should respond" do
        expect{ subject }.to_not raise_error
      end
    end

    describe "#to_a" do
      subject { OrderedWeek.new.to_a }

      it "should respond" do
        expect{ subject }.to_not raise_error
      end
    end

    describe "#each" do
      subject { OrderedWeek.new.each {|obj| obj} }

      it "should respond" do
        expect{ subject }.to_not raise_error
      end

      it "should make for enumerable operations" do
        enum_return = OrderedWeek.new.map {|obj| obj.strftime("%F")}
        enum_return.each {|e_obj| e_obj.should be_a String}
      end
    end

  end
end
