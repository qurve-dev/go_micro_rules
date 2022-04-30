""" Rule implementation to build go library with Go Micro boilerplate generated """

load("@rules_proto_grpc//:defs.bzl", "ProtoPluginInfo", "proto_compile_attrs", "proto_compile_impl")

go_micro_protobuf_compile = rule(
    implementation = proto_compile_impl,
    attrs = dict(
        proto_compile_attrs,
        _plugins = attr.label_list(
            providers = [ProtoPluginInfo],
            default = [
                Label("@rules_proto_grpc//go:grpc_go_plugin"),
                Label("@rules_proto_grpc//go:go_plugin"),
                Label("//build/bazelrules/gomicro:go_micro_plugin"),
            ],
            doc = "List of protoc plugins to apply",
        ),
    ),
    toolchains = [str(Label("@rules_proto_grpc//protobuf:toolchain_type"))],
)
