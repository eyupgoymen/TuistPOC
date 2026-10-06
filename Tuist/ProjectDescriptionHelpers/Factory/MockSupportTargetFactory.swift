import ProjectDescription

public struct MockSupportTargetFactory {
  public init() {}
  
  public func make(
    name: String,
    dependencies: [TargetDependency]
  ) -> Target {
    let bundleId = String(
      format: "%@.%@.%@",
      Global.bundleIdentifierPrefix, name, TargetType.mockSupport
    ).lowercased()
    
    return Target.target(
      name: name + TargetType.mockSupport,
      destinations: Global.destionations,
      product: ProductConfig.mockSupportProduct,
      bundleId: bundleId,
      deploymentTargets: Global.deploymentTargets,
      infoPlist: .default,
      sources: ["../\(name)/\(TargetType.mockSupport)/**"],
      dependencies: dependencies,
      settings: SubTargetBuildSettingsFactory().make()
    )
  }
}
