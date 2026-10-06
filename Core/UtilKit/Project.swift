import ProjectDescription
import ProjectDescriptionHelpers

public let UtilKit = ModuleProjectFactory.make(
  name: "UtilKit",
  moduleType: .library,
  layer: .core,
  unitTestAvailability: .available(dependencies: .empty),
  executableAvailability: .unavailable,
  mockSupportAvailability: .available(dependencies: .empty),
  contractAvailability: .available(dependencies: .empty),
  dependencies: [
    utilKit.contract
  ]
)
