// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "LogDog",
    platforms: [
            .iOS(.v16),
            .macOS(.v13),
            .tvOS(.v16),
            .watchOS(.v9),
            .visionOS(.v1),
        ],
    products: [
        .library(
            name: "LogDog",
            targets: ["LogDog"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "LogDog"),
        .testTarget(
            name: "LogDogTests",
            dependencies: ["LogDog"]),
    ]
)
