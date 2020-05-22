# Simple test client to send some messages to fluent grpc input

this_dir = File.expand_path(File.dirname(__FILE__))
$LOAD_PATH.unshift(this_dir) unless $LOAD_PATH.include?(this_dir)

require 'grpc'
require 'fluent-grpc_services_pb'

def main
  stub = Fluent::Grpc::Logging::Stub.new('localhost:50051', :this_channel_is_insecure)
  message = stub.send_log(Fluent::Grpc::LogRequest.new(tag: "my.app", message: "Hello World"))
  p "LogResponse: #{message}"
end

main