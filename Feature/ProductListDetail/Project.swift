import ProjectDescription
import ProjectDescriptionHelpers

public let ProductListDetail = ModuleProjectFactory.make(
  name: "ProductListDetail",
  moduleType: .framework(hasResources: true),
  layer: .feature,
  unitTestAvailability: .available(dependencies: .empty),
  executableAvailability: .available(dependencies: [
    productListDetail.impl
  ]),
  mockSupportAvailability: .available(dependencies: .empty),
  contractAvailability: .available(dependencies: .empty),
  dependencies: [
    productListDetail.contract,
    productDomain.contract
  ]
)
