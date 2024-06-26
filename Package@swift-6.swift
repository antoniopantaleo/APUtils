// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "APUtils",
    platforms: [.iOS(.v13), .macOS(.v10_15)],
    products: [
        .library(
            name: "APUtils",
            targets: ["APUtils", "MockMacroAPI"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax.git", branch: "release/6.0"),
    ],
    targets: [
        .target(name: "APUtils"),
        .macro(
            name: "MockMacro",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
            ],
            path: "Sources/Macros/MockMacro",
            sources: ["MockMacro.swift"],
            swiftSettings: [
                .enableExperimentalFeature("BodyMacros")
            ]
        ),
        .target(
            name: "MockMacroAPI",
            dependencies: ["MockMacro"],
            path: "Sources/Macros/MockMacro",
            sources: ["MockMacroAPI.swift"],
            swiftSettings: [
                .enableExperimentalFeature("BodyMacros"),
            ]
        ),
        .testTarget(
            name: "APUtilsTests",
            dependencies: ["APUtils"]
        ),
        .testTarget(
            name: "MacroTests",
            dependencies: [
                "MockMacro",
                .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax")
            ]
        )
    ]
)
