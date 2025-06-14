// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TempleRunClone",
    platforms: [
        .iOS(.v15)
    ],
    targets: [
        .executableTarget(
            name: "TempleRunClone",
            path: "Sources",
            publicHeadersPath: "include",
            resources: [
                .process("Resources")
            ]
        )
    ]
)
