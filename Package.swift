// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "Networking",
    platforms: [
        .ios(.v9),
    ],
    products: [
        .library(name: "Networking", type: .dynamic, targets: ["MyLibrary"]),
    ],
    dependencies: [

    ],
    targets: [
        .target(name: "Networking", dependencies: []),
        .testTarget(name: "NetworkingTests", dependencies: ["Networking"]),
    ]
)