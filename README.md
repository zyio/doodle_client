# DoodleClient

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'doodle_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install doodle_client

## Usage

### Verify

Checks if a provided URL or id is a valid doodle.com reference.

Takes a string, returns true or false.

```ruby
 2.3.0 :001 > require 'doodle_client'
  => true
 2.3.0 :002 > DoodleClient.verify("http://doodle.com/poll/kfha4cefe7zutuqu")
  => true
 2.3.0 :003 > DoodleClient.verify("kfha4cefe7zutuqu")
  => true
 2.3.0 :004 > DoodleClient.verify("http://doodle.com/poll/notarealdoodleid")
  => false
 2.3.0 :005 > DoodleClient.verify("notarealdoodleid")
  => false
```

### List

Lists the various options available on the poll. Currently doesn't have useul information like value.

Takes a string of either URL or id again.

```ruby
 2.3.0 :001 > require 'doodle_client'
  => true
 2.3.0 :002 > DoodleClient.list("http://doodle.com/poll/kfha4cefe7zutuqu")
  => [[checkbox:0xce6a1c type: checkbox name: option0 value: false], [checkbox:0xce6850 type: checkbox name: option1 value: false], [checkbox:0xce6634 type: checkbox name: option2 value: false], [checkbox:0xce6468 type: checkbox name: option3 value: false]]
 2.3.0 :003 > DoodleClient.list("kfha4cefe7zutuqu")
  => [[checkbox:0xc8e77c type: checkbox name: option0 value: false], [checkbox:0xc8e560 type: checkbox name: option1 value: false], [checkbox:0xc8e344 type: checkbox name: option2 value: false], [checkbox:0xc8e164 type: checkbox name: option3 value: false]]

```

### Vote

The main event, lets you vote on a poll. 

Takes a string for URL/id, a string for the name you want to vote as and an array of true or false to reflect if you're attending or not.

```ruby
 2.3.0 :001 > require 'doodle_client'
  => true
 2.3.0 :002 > DoodleClient.vote("http://doodle.com/poll/kfha4cefe7zutuqu", "Sam", [true, false, true])
  => true
 2.3.0 :003 > DoodleClient.vote("kfha4cefe7zutuqu", "Jim", [false, false, true])
  => true
```

Resulting in:

![Doodle](http://i.imgur.com/fOm7DjG.png)

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/zyio/doodle_client.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

