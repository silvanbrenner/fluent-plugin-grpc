# fluent-plugin-grpc
Fluent input plugin for gRPC

## Installation

### RubyGems

```
$ gem install fluent-plugin-grpc-2
```

### Bundler

Add following line to your Gemfile:

```rub
gem "fluent-plugin-grpc-2"
```

And then execute:

```
$ bundle
```

## Configuration

You can generate configuration template:

```
$ fluent-plugin-config-format input grpc-2
```

# Development

## Build

```
$ gem build fluent-plugin-grpc.gemspec
```

## Setup gRCP

```
$ gem install grpc
```

```
$ gem install grpc-tools
```

```
$ grpc_tools_ruby_protoc -I lib/fluent/plugin/proto --ruby_out=lib/fluent/plugin --grpc_out=lib/fluent/plugin lib/fluent/plugin/proto/fluent-grpc.proto
```

## Setup fluentd

```
$ gem install fluentd
```

### Starting and testing fluentd

```
$ fluentd -c conf/fluentd.conf -vv
```

```
$ curl --header "Content-Type: application/json" --request POST --data "{\"json\":\"message\"}" http://localhost:9880
```

```
$ ruby demo_client.rb
```

## Copyright

* Copyright(c) 2020- Silvan Brenner
* License
  * Apache License, Version 2.0
