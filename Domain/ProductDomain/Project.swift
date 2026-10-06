import ProjectDescription
import ProjectDescriptionHelpers

public let ProductDomain = ModuleProjectFactory.make(
  name: "ProductDomain",
  moduleType: .library,
  layer: .domain,
  unitTestAvailability: .available(dependencies: .empty),
  executableAvailability: .unavailable,
  mockSupportAvailability: .available(dependencies: .empty),
  contractAvailability: .available(dependencies: .empty),
  dependencies: [
    productDomain.contract
  ]
)
