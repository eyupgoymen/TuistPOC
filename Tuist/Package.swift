// swift-tools-version: 6.2
import PackageDescription

#if TUIST
import struct ProjectDescription.PackageSettings
import ProjectDescriptionHelpers

let packageSettings = PackageSettings(
  productTypes: [
    "Kingfisher": ProductConfig.packageProduct,
    "FactoryKit": ProductConfig.packageProduct
  ]
)
#endif

let package = Package(
    name: "TuistPOC",
    dependencies: [
      .package(url: "https://github.com/onevcat/Kingfisher.git", exact: "8.3.3"),
      .package(url: "https://github.com/hmlongco/Factory", exact: "2.5.3"),
    ]
)
