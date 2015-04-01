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

### Generate

    id = PropertybaseId.generate(object: "team")
    =>  #<PropertybaseId:0x007f90e3dcf048 @counter=1, @host_id=1203, @object="team", @object_id=2, @process_id=254, @time=1427867006>

For string representation do:

    id.to_s
    => "002xfnm458e72001"

### Parsing

To get a PropertybaseId object from a string representation do:

    PropertybaseId.parse("002xfnm458e72001")
    => #<PropertybaseId:0x007f90e3d57f48 @counter=1, @host_id=1203, @object="team", @object_id=2, @process_id=254, @time=1427867006>

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/propertybase_id/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am "Add some feature"`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
