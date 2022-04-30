load(":compile.bzl", _go_micro_protobuf_compile = "go_micro_protobuf_compile")
load(":library.bzl", _go_micro_protobuf_library = "go_micro_protobuf_library")

go_micro_protobuf_compile = _go_micro_protobuf_compile
go_micro_protobuf_library = _go_micro_protobuf_library
