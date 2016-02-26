# OrderedWeek

A class useful for when it makes sense to think of a week, conceptually, as a single object.
An example, at least my use case, would be an app tracking pay periods. It makes sense to explicitly label a beginning marker.

## Installation

Add this line to your application's Gemfile:

    gem 'ordered_week'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ordered_week

## Usage

You now have access to the OrderedWeek class, which returns an array of Dates, which includes an optionally given Date (defaults to including current day).
Note: The following examples assume the current date to be Sunday, 2014-02-16.

    OrderedWeek.new
    #=> [2014-02-10, 2014-02-11, ... ]
    OrderedWeek.new(Date.today - 7)
    #=> [2014-02-03, 2014-02-04, ... ]

The constructor accepts any object that responds to `.to_date` (such as Times),
and returns a week containing that date.

    OrderedWeek.new(1.week.ago)
    #=> [2014-02-03, 2014-02-04, ... ]

These collections have a concept of where they start and end.

    OrderedWeek.new.start_date
    #=> #<Date: 2014-02-10 ((2456699j,0s,0n),+0s,2299161j)>
    OrderedWeek.new.end_date
    #=> #<Date: 2014-02-16 ((2456705j,0s,0n),+0s,2299161j)>

By default, the "week" starts on Monday. You can change this by setting the class option.
Note: The following example shows that by resetting the start date for the week, a completely different week can be returned.

    OrderedWeek.start_day
    #=> :monday
    OrderedWeek.start_day = :sunday
    #=> :sunday
    OrderedWeek.new.start_date
    #=> #<Date: 2014-02-16 ((2456705j,0s,0n),+0s,2299161j)>

Don't worry though! If you accidentally pass an argument that isn't the symbol of a valid day of the week, nothing changes

    OrderedWeek.start_day
    #=> :monday
    OrderedWeek.start_day = :bad
    #=> :bad
    OrderedWeek.start_day
    #=> :monday

In addition to the class-level configuration, `OrderedWeek.new` accepts an optional argument for the start day.

    OrderedWeek.start_day
    #=> :monday
    OrderedWeek.new(Date.today)
    #=> [2014-02-10, 2014-02-11, ... ]
    OrderedWeek.new(Date.today, :sunday)
    #=> [2014-02-16, 2014-02-17, ... ]

These objects respond to the following methods

    OrderedWeek.new.monday
    #=> #<Date: 2014-02-10 ((2456699j,0s,0n),+0s,2299161j)>

    ...

    OrderedWeek.new.sunday
    #=> #<Date: 2014-02-16 ((2456705j,0s,0n),+0s,2299161j)>

    OrderedWeek.new.to_a
    #=> [#<Date: 2014-02-10 ((2456699j,0s,0n),+0s,2299161j)>, #<Date: 2014-02-11 ((2456700j,0s,0n),+0s,2299161j)>, ... ]

The objects are also enumerable, so feel free to modify your Dates however you need

    OrderedWeek.new.map {|day| day.strftime("%F")}
    #=> ["2014-02-10", "2014-02-11", ... ]

## Contributing

1. Fork it ( http://github.com/<my-github-username>/ordered_week/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
