load("@bazel_gazelle//:deps.bzl", "go_repository")

def go_micro_repositories():
    go_repository(
        name = "dev_go_micro_v4",
        importpath = "go-micro.dev/v4",
        sum = "h1:sY1Ps3Vgq8tFzcUGps9WnJhy1AKspXK+4wWIwugiRss=",
        # This is mandatory since micro is pre-generating their protobuf.
        # Otherwise a conflict is created.
        build_file_proto_mode = "disable",
        version = "v4.6.0",
    )
