// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "which-quarter",
    platforms: [
        .macOS(.v15)
    ],
    dependencies: [
        // .package(url: "https://github.com/apple/swift-argument-parser.git", branch: "main"),
        .package(url: "https://github.com/leviouwendijk/plate.git", branch: "master"),
    ],
    targets: [
        .executableTarget(
            name: "q",
            dependencies: [
                // .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "plate", package: "plate"),
            ]
        ),
    ]
)
