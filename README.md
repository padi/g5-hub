# G5 Hub

[![Build Status](https://travis-ci.org/G5/g5-hub.png?branch=master)](https://travis-ci.org/G5/g5-hub)
[![Code Climate](https://codeclimate.com/repos/5310f787695680105d0004fd/badges/81beec1c8fb005c9521c/gpa.png)](https://codeclimate.com/repos/5310f787695680105d0004fd/feed)

Client information is managed by G5.

* Creates Clients
* Creates Locations
* Publishes Client Entries/Feed
* Webhooks Client Feed Subscribers

## Setup

1. Install all gem dependencies.
```bash
$ bundle
```

1. Set up your database.
[rails-default-database](https://github.com/tpope/rails-default-database)
automatically uses sensible defaults for the primary ActiveRecord database.
```bash
$ rake db:setup
```

### Optional: To Webhook G5 Configurator

1. Set environment variable `G5_CONFIGURATOR_WEBHOOK_URL`.
Defaults are set in `config/initializers/env.rb`.


## Authors

* Jessica Lynn Suttles / [@jlsuttles](https://github.com/jlsuttles)
* Bookis Smuin / [@bookis](https://github.com/bookis)
* Don Petersen / [@dpetersen](https://github.com/dpetersen)
* Michael Mitchell / [@variousred](https://github.com/variousred)
* Jessica Dillon / [@jessicard](https://github.com/jessicard)
* Chad Crissman / [@crissmancd](https://github.com/crissmancd)


## Contributing

1. Get it running
1. Create your feature branch (`git checkout -b my-new-feature`)
1. Write your code and **specs**
1. Commit your changes (`git commit -am 'Add some feature'`)
1. Push to the branch (`git push origin my-new-feature`)
1. Create new Pull Request

If you find bugs, have feature requests or questions, please
[file an issue](https://github.com/G5/g5-hub/issues).


## Specs

Run once.
```bash
$ rspec spec
```

Keep then running.
```bash
$ guard
```

Coverage.
```bash
$ rspec spec
$ open coverage/index.html
```


## License

Copyright (c) 2013 G5

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
