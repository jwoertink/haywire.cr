require "../src/haywire"

# Create a config
config = LibHaywire::Config.new
config.http_listen_address = "0.0.0.0"
config.http_listen_port = 3000
config.thread_count = 0
config.balancer = "ipc"
config.parser = "http_parser"
config.max_request_size = 1048576
config.tcp_nodelay = true
config.listen_backlog = 0

# This throws a Invalid memory access error :(
LibHaywire.init_with_config(pointerof(config))
LibHaywire.http_add_route("/", -> {
  "Hello World"
}, nil)
LibHaywire.http_open

