// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "Dimensions",
    platforms: [
        .iOS(.v16),
        .tvOS(.v16),
        .macOS(.v13),
        .watchOS(.v9),
        .visionOS(.v1),
    ],
    products: [
        .library(
            name: "Dimensions",
            targets: ["Dimensions"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/heestand-xyz/CoreGraphicsExtensions", from: "2.0.1"),
        .package(url: "https://github.com/heestand-xyz/SpatialExtensions", from: "1.0.1"),
    ],
    targets: [
        .target(
            name: "Dimensions",
            dependencies: [
                "CoreGraphicsExtensions",
                "SpatialExtensions",
            ]
        ),
    ]
)
