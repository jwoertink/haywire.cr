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
LibHaywire.http_add_route("/", ->(request : LibHaywire::HTTP_Request, response : LibHaywire::HTTP_Response, user_data : Void*) {
  status_code = LibHaywire::HW_String.new(value: LibHaywire::HTTP_STATUS_200, length: 6)
  LibHaywire.set_response_status_code(pointerof(response), pointerof(status_code))

  content_type_name = LibHaywire::HW_String.new(value: "Content-Type", length: 12)
  content_type_value = LibHaywire::HW_String.new(value: "text/html", length: 9)
  LibHaywire.set_response_header(pointerof(response), pointerof(content_type_name), pointerof(content_type_value))

  body = LibHaywire::HW_String.new(value: "Hello World", length: 11)
  LibHaywire.set_body(pointerof(response), pointerof(body))

  LibHaywire.http_response_send(pointerof(response), "user_data", ->(request : LibHaywire::HTTP_Request, response : LibHaywire::HTTP_Response, user_data : Void*) {})
}, nil)
LibHaywire.http_open

