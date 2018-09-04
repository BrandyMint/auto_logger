# AutoLogger
[![Build
Status](https://travis-ci.org/BrandyMint/moysklad.svg)](https://travis-ci.org/dapi/moysklad)

Упрощяет подключение уникальных логгеров для модулей и классов. После
подключения в модуль или класс через `include AutoLogger` добавляет метод
`logger` который пишет логи в файл автоматически сформированные из измени
модуля/класса в каталог `./log`

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'auto_logger'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install auto_logger

## Usage

```
module SomeService
  include AutoLogger

  def perform
    logger.info 'some' # writes info into ./logs/some_service.log
  end
end
```

Иногда необходимо насильно указать имя файла для лога. Например при подключении
в модули/класс без имени, в частности в grape-контролерах:

```
class PublicAPI::OrdersAPI < Grape::API
  helpers do
    include AutoLogger::Named.new(name: :orders_api)
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dapi/auto_logger. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the AutoLogger project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/dapi/auto_logger/blob/master/CODE_OF_CONDUCT.md).
