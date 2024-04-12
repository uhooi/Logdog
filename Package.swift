// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "Logdog",
    platforms: [
            .iOS(.v16),
            .macOS(.v13),
            .tvOS(.v16),
            .watchOS(.v9),
            .visionOS(.v1),
        ],
    products: [
        .library(
            name: "Logdog",
            targets: ["Logdog"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Logdog"),
        .testTarget(
            name: "LogdogTests",
            dependencies: ["Logdog"]),
    ]
)
