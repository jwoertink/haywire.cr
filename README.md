# haywire.cr

A crystal c-binding around [Haywire](https://github.com/haywire/haywire) used for HTTP server/client

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  haywire:
    github: jwoertink/haywire.cr
```

## Usage

**NOTE** currently broken

```crystal
require "haywire"

# Create a config
config = LibHaywire::Config.new
config.http_listen_address = "0.0.0.0"
config.http_listen_port = 3000
config.thread_count = 1

# This throws a Invalid memory access error :(
LibHaywire.init_with_config(pointerof(config))
LibHaywire.http_add_route("/", -> {
  "Hello World"
}, nil)
LibHaywire.http_open
```


## Development

The goal would be to have a 1 to 1 mapping to crystal's built in `HTTP` library. Then being able to switch it out for this (provided this is any better?)


## Contributing

1. Fork it ( https://github.com/jwoertink/haywire/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [jwoertink](https://github.com/jwoertink) Jeremy Woertink - creator, maintainer
