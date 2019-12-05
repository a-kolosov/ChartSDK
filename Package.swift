// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "ChartSDK",
    platforms: [
          .iOS(.v10)
    ],
    products: [
        .library(
            name: "ChartSDK",
            targets: ["ChartSDK"]),
    ],
    targets: [
        .target(name: "ChartSDK", path: "ChartSDK/Classes")
    ],
    swiftLanguageVersions: [.v5]
)
