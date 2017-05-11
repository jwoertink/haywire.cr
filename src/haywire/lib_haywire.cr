@[Link(ldflags: "-lhaywire -luv")]
lib LibHaywire
  alias Char = LibC::Char
  alias UChar = LibC::UChar
  alias Int = LibC::Int
  alias UInt = LibC::UInt
  alias SizeT = LibC::SizeT
  alias UShort = LibC::UShort
  HTTP_STATUS_200 = "200 OK"

  struct HW_String
    value : Char*
    length : SizeT
  end

  struct Config
    http_listen_address : Char*
    http_listen_port : UInt
    thread_count : UInt
    balancer : Char*
    parser : Char*
    tcp_nodelay : Bool
    listen_backlog : UInt
    max_request_size : UInt
  end

  enum State
    OK
    SIZE_EXCEEDED
    BAD_REQUEST
    INTERNAL_ERROR
  end

  alias HTTP_Response = Void*

  struct HTTP_Request
    http_major : UShort
    http_minor : UShort
    method : UChar
    keep_alive : Int
    url : HW_String*
    headers : Void*
    body : HW_String*
    body_length : SizeT
    state : State
  end

  fun init_from_config = hw_init_from_config(configuration_filename : Char*) : Int
  fun init_with_config = hw_init_with_config(config : Config*) : Int
  fun http_open = hw_http_open() : Int
  fun http_add_route = hw_http_add_route(route : Char*, callback : (HTTP_Request, HTTP_Response, Void*)->, user_data : Void*)
  fun get_header = hw_get_header(request : HTTP_Request*, key : HW_String*) : HW_String*

  fun free_http_response = hw_free_http_response(response : HTTP_Response*) : Void
  fun set_http_version = hw_set_http_version(response : HTTP_Response*, major : UShort, minor : UShort) : Void
  fun set_response_status_code = hw_set_response_status_code(response : HTTP_Response*, status_code : HW_String*) : Void
  fun set_response_header = hw_set_response_header(response : HTTP_Response*, name : HW_String*, value : HW_String*) : Void
  fun set_body = hw_set_body(response : HTTP_Response*, body : HW_String*) : Void
  fun http_response_send = hw_http_response_send(response : HTTP_Response*, user_data : Void*, callback : (HTTP_Request, HTTP_Response, Void* )->)

  fun print_request_headers = hw_print_request_headers(request : HTTP_Request*)
end

