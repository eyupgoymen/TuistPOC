import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
  name: "TuistPOC",
  targets: [
    .target(
      name: "TuistPOC",
      destinations: [.iPhone, .mac],
      product: .app,
      bundleId: "com.tuistpoc.app",
      deploymentTargets: .iOS("15.0"),
      infoPlist: .default,
      sources: ["TuistPOC/Sources/**"],
      resources: ["TuistPOC/Resources/**"],
      dependencies: [
        .external(name: "Factory"),
        .external(name: "Kingfisher")
      ]
    ),
    .target(
      name: "TuistPOCTests",
      destinations: [.iPhone, .mac],
      product: .unitTests,
      bundleId: "com.tuistpoc.app.tests",
      deploymentTargets: .iOS("15.0"),
      infoPlist: .default,
      sources: ["TuistPOC/Tests/**"],
      dependencies: [
        .target(name: "TuistPOC")
      ]
    ),
  ]
)
