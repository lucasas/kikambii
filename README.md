# Kikambii

Kikambii runs all feature included in `"#{Rails.root}/rerun.txt"` file generated by cucumber. Kikambii because it is the way to pronounce Cucumber in a common dialect of Minas Gerais.

If you run cucumber on CI (like Jenkins) and your tests are very unstable, the common solution is using `-f rerun -o rerun.txt` with `cucumber` command.

Using `rake kikambii` the possible failures saved on rerun.txt file will be executed one per time. So, if your rerun.txt contain the following result:

    features/some-feature.feature:58:104:250 features/other-feature.feature:21:42

Kikambii will run this:

    cucumber -f pretty features/some-feature.feature:58
    cucumber -f pretty features/some-feature.feature:104
    cucumber -f pretty features/some-feature.feature:250
    cucumber -f pretty features/other-feature.feature:21
    cucumber -f pretty features/other-feature.feature:42

## Installation

Add this line to your application's Gemfile:

    gem 'kikambii'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kikambii

## Usage

Put `require 'kikambii'` into your Rakefile

Configure cucumber to run with `-f rerun -o "#{Rails.env}/rerun.txt"`

And after run `cucumber` command, you should run `rake kikambii`

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
