// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "hw27_advanced_operators",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "hw27_advanced_operators",
            dependencies: []),
        .testTarget(
            name: "hw27_advanced_operatorsTests",
            dependencies: ["hw27_advanced_operators"]),
    ]
)
