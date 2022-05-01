# Bazel rules for Go-micro

[Go micro](https://go-micro.dev) is a great framework that offers automatically generated 
golang code from protobuf definitions to avoid writing troublesome boilerplate. 

Those rules are depending on [Rules proto grpc](https://rules-proto-grpc.com/en/latest/) make sure it is installed
properly in your workspace.

🚧 Those rules are considered unstable at the moment and we do not recommend using
it in production until we consolidate APIs.

## How to install

Make sure to install required dependencies in your workspace:

```python
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "rules_proto_grpc",
    sha256 = "507e38c8d95c7efa4f3b1c0595a8e8f139c885cb41a76cab7e20e4e67ae87731",
    strip_prefix = "rules_proto_grpc-4.1.1",
    urls = ["https://github.com/rules-proto-grpc/rules_proto_grpc/archive/4.1.1.tar.gz"],
)

http_archive(
    name = "rules_go_micro",
    sha256 = "507e38c8d95c7efa4f3b1c0595a8e8f139c885cb41a76cab7e20e4e67ae87731",
    strip_prefix = "rules_go_micro-0.0.1",
    urls = ["https://github.com/graphpod/go_micro_rules/archive/0.0.1.tar.gz"],
)

load("@rules_proto_grpc//:repositories.bzl", "rules_proto_grpc_toolchains", "rules_proto_grpc_repos")
rules_proto_grpc_toolchains()
rules_proto_grpc_repos()

load("@rules_proto//proto:repositories.bzl", "rules_proto_dependencies", "rules_proto_toolchains")
rules_proto_dependencies()
rules_proto_toolchains()

load("@rules_go_micro//:repositories.bzl", "go_micro_repositories")
go_micro_repositories()
```

## How to use

```python
load("//build/bazelrules/gomicro:defs.bzl", "go_micro_protobuf_library")
load("@rules_proto_grpc//go:defs.bzl", "go_grpc_library")

proto_library(
    name = "sample_proto",
    srcs = ["sample.proto"],
)

# This rule will generate the ".go" file but you still need 
# to compile it
go_micro_protobuf_library(
    name = "sample_micro_proto",
    importpath = "github.com/graphpod/mono/services/sample/proto",
    protos = [":sample_proto"],
    visibility = ["//visibility:public"],
)

# This rule will generate GRPC + Protobuf + Gomicro and compile it with the
# right dependencies
go_micro_protobuf_compile(
    name = "sample_micro_proto",
    importpath = "github.com/graphpod/mono/services/sample/proto",
    protos = [":sample_proto"],
    visibility = ["//visibility:public"],
)
```