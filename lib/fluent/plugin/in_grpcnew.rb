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
require 'fluent-input_services_pb'

class LoggingServer < Fluentinput::Logging::Service
  def send_log(log_req, _unused_call)
    Fluentinput::LogResponse.new(message: "Hello #{log_req.message}")
  end
end

class Server
  def start
    @server = GRPC::RpcServer.new
    @server.add_http2_port('0.0.0.0:50051', :this_port_is_insecure)
    @server.handle(LoggingServer)
    @server.run_till_terminated
  end
end

module Fluent
  module Plugin
    class GrpcInput < Fluent::Plugin::Input
      Fluent::Plugin.register_input("grpcnew", self)

      config_param :port, :integer, default: 50051

      def configure(conf)
        super

        if @port < 1024
          raise Fluent::ConfigError, "well known ports cannot be used for this purpose."
        end

        @port = conf['port']
      end

      def start
        super
        log.info "Starting grpcnew input plugin"
        s = Server.new
        s.start
      end

      def shutdown
        log.info "Shutdown grpcnew input plugin"
        super
      end
    end
  end
end
