import ProjectDescription
import ProjectDescriptionHelpers

public let NetworkingKit = ModuleProjectFactory.make(
  name: "NetworkingKit",
  moduleType: .library,
  layer: .core,
  unitTestAvailability: .available(dependencies: .empty),
  executableAvailability: .unavailable,
  mockSupportAvailability: .available(dependencies: .empty),
  contractAvailability: .available(dependencies: .empty),
  dependencies: [
    networkingKit.contract,
    kingfisher
  ]
)
