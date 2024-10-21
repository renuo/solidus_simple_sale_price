
# Solidus Simple Sale Price

The `Solidus Simple Sale Price` gem adds support for a single sale price per `Spree::Price` in Solidus, making it easier to manage discounted pricing.

## Features

- Adds sale price functionality to `Spree::Price`.
- Easy integration with existing Solidus pricing mechanisms.
  
## Installation

To install `solidus_simple_sale_price`, add the following to your `Gemfile`:

```ruby
gem 'solidus_simple_sale_price'
```

Then, run the installation generator after bundling your dependencies:

```shell
bundle install
bin/rails generate solidus_simple_sale_price:install
```

## Development

### Testing

To run tests for this extension, follow these steps:

1. Bundle your dependencies:

```shell
bundle install
```

2. Run the tests:

```shell
bin/rake
```

The above command will build the dummy app if it doesn't exist and then run the specs. If you need to regenerate the dummy app, use:

```shell
bin/rake extension:test_app
```

You can also run static code analysis with [Rubocop](https://github.com/bbatsov/rubocop):

```shell
bundle exec rubocop
```

When testing your application's integration with this extension, you can load Solidus core factories and this extension's factories:

```ruby
SolidusDevSupport::TestingSupport::Factories.load_for(SolidusSimpleSalePrice::Engine)
```

### Sandbox

To test the extension in a sandboxed Solidus application, run:

```shell
bin/sandbox
```

This creates a sandboxed Solidus app in `./sandbox`, and you can forward any Rails command using:

```shell
bin/rails server
```

Example:

```shell
$ bin/rails server
=> Booting Puma
=> Rails 6.0.2.1 application starting in development
* Listening on tcp://127.0.0.1:3000
Use Ctrl-C to stop
```

## License

This gem is released under the [New BSD License](https://opensource.org/licenses/BSD-3-Clause).  
Copyright (c) 2024 Renuo AG
