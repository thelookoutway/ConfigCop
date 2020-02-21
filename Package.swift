// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ConfigCop",
    platforms: [
        .macOS(.v10_15),
    ],
    products: [
        .library(name: "ConfigCop", targets: ["ConfigCop"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/jpsim/Yams.git",
            from: "2.0.0"
        ),
        .package(
            url: "https://github.com/apple/swift-package-manager.git",
            from: "0.5.0"
        )
    ],
    targets: [
        .target(
            name: "ConfigCop",
            dependencies: ["ConfigCopCore", "SPMUtility"]),
        .target(
            name: "ConfigCopCore",
            dependencies: ["Yams"]),
        .testTarget(
            name: "ConfigCopTests",
            dependencies: ["ConfigCopCore", "Yams"]),
    ]
)
