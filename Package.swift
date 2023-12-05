// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "Twifter",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "Twifter", targets: ["Twifter"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Quick", from: "7.3.0"),
        .package(url: "https://github.com/Quick/Nimble", from: "13.0.0"),
    ],
    targets: [
        .target(name: "Twifter"),
        .testTarget(name: "TwifterTests", dependencies: [
            "Twifter",
            .product(name: "Quick", package: "Quick"),
            .product(name: "Nimble", package: "Nimble"),
        ]),
    ]
)
