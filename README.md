# G5 Hub

* Publishes a feed consumed by g5-configurator
* Pings g5-configurator when feed is updated via webhook


## Setup

1. Install all the required gems
```bash
bundle
```

1. Set up your database
```bash
cp config/database.example.yml config/database.yml
vi config/database.yml # edit username
rake db:create db:schema:load db:seed
```

1. Export environment variables
```bash
export CONFIGURATOR_WEBHOOK_URL=http://foo.bar/
```


## Authors

* Jessica Lynn Suttles / [@jlsuttles](https://github.com/jlsuttles)
* Bookis Smuin / [@bookis](https://github.com/bookis)


## Contributing

1. Fork it
1. Get it running
1. Create your feature branch (`git checkout -b my-new-feature`)
1. Write your code and **specs**
1. Commit your changes (`git commit -am 'Add some feature'`)
1. Push to the branch (`git push origin my-new-feature`)
1. Create new Pull Request

If you find bugs, have feature requests or questions, please
[file an issue](https://github.com/g5search/g5-hub/issues).

## Specs

```bash
guard
```
