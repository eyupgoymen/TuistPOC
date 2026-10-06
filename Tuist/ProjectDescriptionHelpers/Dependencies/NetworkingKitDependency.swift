import ProjectDescription

public let networkingKit = NetworkingKit()

public struct NetworkingKit: Sendable {
  private let name = "NetworkingKit"
  private let directory = "Core"
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
