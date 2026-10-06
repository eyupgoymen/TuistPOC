import ProjectDescription

public let productList = ProductList()

public struct ProductList: Sendable {
  private let name = "ProductList"
  private let directory = "Feature"
  private let dependencyProvider: TargetDependencyProvider
  
  public var impl: TargetDependency {
    return dependencyProvider.implTarget
  }
  
  public var contract: TargetDependency {
    return dependencyProvider.contractTarget
  }
  
  public var mockSupport: TargetDependency {
    return dependencyProvider.mockSupportTarget
  }
  
  init() {
    dependencyProvider = TargetDependencyProvider(
      name: name,
      directory: directory
    )
  }
}
