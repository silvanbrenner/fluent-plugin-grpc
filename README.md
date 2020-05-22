# fluent-plugin-grpc
Fluent input plugin for gRPC

## Installation

### RubyGems

```
$ gem install fluent-plugin-grpcnew
```

### Bundler

Add following line to your Gemfile:

```ruby
gem "fluent-plugin-grpcnew"
```

And then execute:

```
$ bundle
```

## Configuration

You can generate configuration template:

```
$ fluent-plugin-config-format input grpcnew
```

# Development

## Build

gem build fluent-plugin-grpcnew.gemspec


## Setup gRCP

gem install grpc

gem install grpc-tools

grpc_tools_ruby_protoc -I lib/fluent/plugin/proto --ruby_out=lib/fluent/plugin --grpc_out=lib/fluent/plugin lib/fluent/plugin/proto/fluent-input.proto

## Setup fluentd

gem install fluentd

### Starting and testing fluentd

fluentd -c conf/fluentd.conf -vv

curl --header "Content-Type: application/json" --request POST --data "{\"json\":\"message\"}" http://localhost:9880

## Copyright

* Copyright(c) 2020- Silvan Brenner
* License
  * Apache License, Version 2.0
