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
//        .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.9.0"),
        .package(name: "Publish", url: "https://github.com/harrydayexe/publish.git", from: "0.9.1"),
//        .package(path: "~/Developer/Publish"),
        .package(name: "SplashPublishPlugin", url: "https://github.com/johnsundell/splashpublishplugin", from: "0.1.0")
    ],
    targets: [
        .executableTarget(
            name: "Harry Day Blog",
            dependencies: ["Publish", "SplashPublishPlugin"]
        )
    ]
)
