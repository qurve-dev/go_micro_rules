# Go micro rules

This repository contains rules that can be used to generate go-micro boilerplate code from
simple protobuf files. It is a thin wrapper around `protoc-gen-micro`.

# How to use

From within Graphpod monorepo:

    load("//build/bazelrules/micro:micro.bzl", "micro_protobuf")
    
    micro_protobuf(
        name = "my_service",
        protos = [
            "//apis/catalog:default_protos"
        ]
    )

    go_library(
      nmae = "service_lib",
      embed = [":my_service"],
      srcs = [
       "main.go",
      ]
    )

The `go_library` target automatically have all the go-micro boilerplate generated and made
available which will save you hours of boilerplate writing.