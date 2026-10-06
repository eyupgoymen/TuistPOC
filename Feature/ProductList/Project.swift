import ProjectDescription
import ProjectDescriptionHelpers

public let ProductList = ModuleProjectFactory.make(
  name: "ProductList",
  moduleType: .framework(hasResources: true),
  layer: .feature,
  unitTestAvailability: .available(dependencies: .empty),
  executableAvailability: .available(dependencies: [
    productList.impl
  ]),
  mockSupportAvailability: .available(dependencies: .empty),
  contractAvailability: .available(dependencies: .empty),
  dependencies: [
    productList.contract
  ]
)
