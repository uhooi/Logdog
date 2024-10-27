// swift-tools-version: 6.0

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
        .library(
            name: "LogdogUI",
            targets: ["LogdogUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.3.0"),
    ],
    targets: [
        .target(
            name: "Logdog"),
        .target(
            name: "LogdogUI",
            dependencies: ["Logdog"]),
        .testTarget(
            name: "LogdogTests",
            dependencies: ["Logdog"]),
    ]
)
