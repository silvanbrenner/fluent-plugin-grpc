#
# Copyright 2020- Silvan Brenner
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

this_dir = File.expand_path(File.dirname(__FILE__))
$LOAD_PATH.unshift(this_dir) unless $LOAD_PATH.include?(this_dir)

require "fluent/plugin/input"
require 'grpc'
require 'fluent-grpc_services_pb'

module Fluent
  module Plugin
    class GrpcInput < Fluent::Plugin::Input
      Fluent::Plugin.register_input("grpc-2", self)

      helpers :thread

      desc 'The address to bind to.'
      config_param :bind, :string, default: '0.0.0.0'
      desc 'The port to listen to.'
      config_param :port, :integer, default: 50051

      class LoggingServer < Fluent::Grpc::Logging::Service

        def initialize(router)
          @router = router
        end

        def send_log(log_req, _unused_call)
          tag = log_req.tag
          time = Fluent::Engine.now
          record = {"message"=>log_req.message}
          @router.emit(tag, time, record)
          Fluent::Grpc::LogResponse.new()
        end
      end

      def configure(conf)
        super

        if @port < 1024
          raise Fluent::ConfigError, "well known ports cannot be used for this purpose."
        end

        @port = conf['port']
      end

      def start
        super
        log.info "Starting grpc input plugin"
        @server = GRPC::RpcServer.new
        @server.add_http2_port("#{@bind}:#{@port}", :this_port_is_insecure)
        @server.handle(LoggingServer.new(router))
        thread_create :in_grpc_server do
          @server.run
        end
      end

      def shutdown
        log.info "Shutdown grpc input plugin"
        @server.stop
        super
      end
    end
  end
end
