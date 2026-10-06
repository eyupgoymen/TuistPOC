import ProjectDescription

public struct ContractTargetFactory {
  public init() {}
  
  public func make(
    name: String,
    dependencies: [TargetDependency]
  ) -> Target {
    let bundleId = String(
      format: "%@.%@.%@",
      Global.bundleIdentifierPrefix, name, TargetType.contract
    ).lowercased()
    
    return Target.target(
      name: name + TargetType.contract,
      destinations: Global.destionations,
      product: ProductConfig.contructProduct,
      bundleId: bundleId,
      deploymentTargets: Global.deploymentTargets,
      infoPlist: .default,
      sources: ["../\(name)/\(TargetType.contract)/**"],
      dependencies: dependencies,
      settings: SubTargetBuildSettingsFactory().make()
    )
  }
}
