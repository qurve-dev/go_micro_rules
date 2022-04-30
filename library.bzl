""" Rule implementation to build go library with Go Micro boilerplate generated """

load(":compile.bzl", "go_micro_protobuf_compile")
load("@io_bazel_rules_go//go:def.bzl", "go_library")
load("@rules_proto_grpc//:defs.bzl", "ProtoPluginInfo", "proto_compile_attrs", "proto_compile_impl")
load("@rules_proto_grpc//go:go_grpc_library.bzl", "GRPC_DEPS")

def go_micro_protobuf_library(name, **kwargs):
    # Compile protos
    name_pb = name + "_micro_pb"
    go_micro_protobuf_compile(
        name = name_pb,
        prefix_path = kwargs.get("prefix_path", kwargs.get("importpath", "")),
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in proto_compile_attrs.keys() and k != "prefix_path"
        }  # Forward args
    )

    # Create go library
    go_library(
        name = name,
        srcs = [name_pb],
        deps = kwargs.get("go_deps", []) + _RULE_DEPS + GRPC_DEPS + kwargs.get("deps", []),
        importpath = kwargs.get("importpath"),
        visibility = kwargs.get("visibility"),
        tags = kwargs.get("tags"),
    )

_RULE_DEPS = [
    "@dev_go_micro_v4//:go_default_library",
    "@dev_go_micro_v4//client:go_default_library",
    "@dev_go_micro_v4//api:go_default_library",
    "@dev_go_micro_v4//server:go_default_library",
    "@org_golang_google_protobuf//proto:go_default_library",
    "@go_googleapis//google/api:annotations_go_proto",
]
