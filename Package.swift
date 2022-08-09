// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Harry Day Blog",
    platforms: [.macOS(.v12)],
    products: [
        .executable(
            name: "Harry Day Blog",
            targets: ["Harry Day Blog"]
        )
    ],
    dependencies: [
//        .package(name: "Publish", url: "https://github.com/harrydayexe/publish.git", from: "0.9.0")
        .package(path: "~/Developer/Publish")
    ],
    targets: [
        .executableTarget(
            name: "Harry Day Blog",
            dependencies: ["Publish"]
        )
    ]
)
