import ProjectDescription

public let utilKit = UtilKit()

public struct UtilKit: Sendable {
  private let name = "UtilKit"
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
