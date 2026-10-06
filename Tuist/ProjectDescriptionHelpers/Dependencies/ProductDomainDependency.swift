import ProjectDescription

public let productDomain = ProductDomain()

public struct ProductDomain: Sendable {
  private let name = "ProductDomain"
  private let directory = "Domain"
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
