// swift-tools-version: 5.6

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "Capturing Photos",
    platforms: [
        .iOS("16.0")
    ],
    products: [
        .iOSApplication(
            name: "Capturing Photos",
            targets: ["App"],
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .asset("AppIcon"),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [

            ],
            capabilities: [
                .camera(purposeString: "This sample app uses the camera."),
                .photoLibrary(purposeString: "This sample app uses your photo library.")
            ]
        )
    ],
    targets: [
        .executableTarget(
            name: "App",
            path: "App"
        )
    ]
)
