// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Twifter",
    platforms: [.iOS(.v11)],
    products: [
        .library(name: "Twifter", targets: ["Twifter"])
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Quick.git", .upToNextMajor(from: "4.0.0")),
        .package(url: "https://github.com/Quick/Nimble.git", .upToNextMajor(from: "9.2.1")),
    ],
    targets: [
        .target(name: "Twifter", dependencies: []),
        .testTarget(name: "TwifterTests", dependencies: ["Twifter", "Quick", "Nimble"])
    ]
)
