# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: fluent-grpc.proto for package 'fluent.grpc'

require 'grpc'
require 'fluent-grpc_pb'

module Fluent
  module Grpc
    module Logging
      class Service

        include GRPC::GenericService

        self.marshal_class_method = :encode
        self.unmarshal_class_method = :decode
        self.service_name = 'fluent.grpc.Logging'

        rpc :sendLog, LogRequest, LogResponse
      end

      Stub = Service.rpc_stub_class
    end
  end
end
