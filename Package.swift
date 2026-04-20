// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "OnboardingStudio",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "OnboardingStudio",
            targets: ["OnboardingStudio"]
        ),
        .library(
            name: "SpotlightGuide",
            targets: ["SpotlightGuide"]
        ),
    ],
    targets: [
        .target(
            name: "OnboardingStudio"
        ),
        .target(
            name: "SpotlightGuide"
        ),
        .testTarget(
            name: "OnboardingStudioTests",
            dependencies: ["OnboardingStudio"]
        ),
        .testTarget(
            name: "SpotlightGuideTests",
            dependencies: ["SpotlightGuide"]
        ),
    ]
)
