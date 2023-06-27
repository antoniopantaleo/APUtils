// swift-tools-version: 5.7.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "APUtils",
    platforms: [.iOS(.v13), .macOS(.v10_15)],
    products: [
        .library(
            name: "APUtils",
            targets: ["APUtils"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "APUtils",
            dependencies: []
        ),
        .testTarget(
            name: "APUtilsTests",
            dependencies: ["APUtils"]
        )
    ]
)
