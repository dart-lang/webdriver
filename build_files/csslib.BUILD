# Automatically generated by "pub global run bazel:bazelify".
# DO NOT MODIFY BY HAND

# Bazelify: 1 libraries.
load("@io_bazel_rules_dart//dart/build_rules:core.bzl", "dart_library")

# Bazelify: 1 binaries.
load("@io_bazel_rules_dart//dart/build_rules:vm.bzl", "dart_vm_binary")

package(default_visibility = ["//visibility:public"])

_PUB_DEPS = [
    "@org_dartlang_pub_args//:args",
    "@org_dartlang_pub_logging//:logging",
    "@org_dartlang_pub_path//:path",
    "@org_dartlang_pub_source_span//:source_span",
]

# Generated automatically for package:csslib
dart_library(
    name = "csslib",
    srcs = glob(["lib/**"]),
    pub_pkg_name = "csslib",
    deps = _PUB_DEPS,
)

# Generated automatically for package:csslib|bin/css.dart
dart_vm_binary(
    name = "css",
    srcs = glob(["bin/**"]),
    script_file = "bin/css.dart",
    deps = _PUB_DEPS + [
        ":csslib",
    ],
)
