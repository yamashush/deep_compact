[![Gem Version](https://badge.fury.io/rb/deep_compactor.svg)](https://badge.fury.io/rb/deep_compactor)
[![Tests](https://github.com/yamashush/deep_compactor/actions/workflows/ci.yml/badge.svg)](https://github.com/yamashush/deep_compactor/actions/workflows/ci.yml)

# DeepCompactor

Add recursive compact methods for nested Array and Hash object.

- `#deep_compact`
- `#deep_compact!`
- `#deep_compact_blank`
- `#deep_compact_blank!`

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add deep_compactor

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install deep_compactor

## Usage

### `#deep_compact` `deep_compact!`

```ruby
using DeepCompactor

array = ["a", nil, ["aa", nil], { aa: 11, bb: nil }]

array.compact
#=> ["a", ["aa", nil], { aa: 11, bb: nil }]

array.deep_compact
#=> ["a", ["aa"], { aa: 11 }]

array.deep_compact!
#=> ["a", ["aa"], { aa: 11 }]
array
#=> ["a", ["aa"], { aa: 11 }]
```

### `#deep_compact_blank` `deep_compact_blank!`

```ruby
using DeepCompactor

hash = { a: 1, b: nil, c: [], d: {}, e: ["aa", nil, [], {}], f: { aa: 11, bb: nil, cc: [], dd: {} }}

hash.compact_blank # required activesupport
#=> { a: 1, e: ["aa", nil, [], {}], f: { aa: 11, bb: nil, cc: [], dd: {}}}

hash.deep_compact_blank
#=> { a: 1, e: ["aa"], f: { aa: 11 }}

hash.deep_compact_blank!
#=> { a: 1, e: ["aa"], f: { aa: 11 }}
hash
#=> { a: 1, e: ["aa"], f: { aa: 11 }}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/deep_compactor. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/deep_compactor/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the DeepCompactor project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/deep_compactor/blob/main/CODE_OF_CONDUCT.md).
