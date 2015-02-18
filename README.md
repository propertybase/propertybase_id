# PropertybaseId

This gem can be utilized to create globally uniqu Propertybase IDs.

## Installation

Add this line to your application"s Gemfile:

```ruby
gem "propertybase_id"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install propertybase_id

## Usage

### Create

    id = PropertybaseId.create(objectt: "team", server: 1)
    => #<PropertybaseId:0x007fe855071a58 @_object_id=2, @local_random=738414242805187245, @object="team", @server=1>

For string representation do:

    id.to_s
    => "02015lyq044bfuel"

### Parsing

To get a PropertybaseId object from a string representation do:

    PropertybaseId.parse("02015lyq044bfuel")
    => #<PropertybaseId:0x007f9943cb48a8 @_object_id=2, @local_random=738414242805187245, @object="team", @server=1>

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/propertybase_id/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am "Add some feature"`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
