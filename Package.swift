// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TempleRunClone",
    platforms: [
        .iOS(.v14)
    ],
    targets: [
        .target(
            name: "TempleRunClone",
            path: "Sources",
            resources: [
                .process("Resources")
            ],
            publicHeadersPath: "include"
        )
    ]
)
