import ProjectDescription

public struct TestTargetFactory {
  public init() { }
  
  public func make(
    name: String,
    dependencies: [TargetDependency]
  ) -> Target {
    let bundleId = String(
      format: "%@.%@.%@",
      Global.bundleIdentifierPrefix, name, TargetType.test
    ).lowercased()
    
    return Target.target(
      name: name + TargetType.test,
      destinations: Global.destionations,
      product: .unitTests,
      bundleId: bundleId,
      deploymentTargets: Global.deploymentTargets,
      infoPlist: .default,
      sources: "../\(name)/\(TargetType.test)/**",
      resources: [],
      dependencies: dependencies + [.target(name: name)],
      settings: SubTargetBuildSettingsFactory().make()
    )
  }
}
