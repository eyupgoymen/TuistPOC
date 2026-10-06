import ProjectDescription

public struct ExecutableTargetFactory {
  public init() {}
  
  public func make(
    name: String,
    dependencies: [TargetDependency]
  ) -> Target {
    let bundleId = String(
      format: "%@.%@.%@",
      Global.bundleIdentifierPrefix, name, TargetType.executable
    ).lowercased()
    
    return Target.target(
      name: name + TargetType.executable,
      destinations: Global.destionations,
      product: .app,
      bundleId: bundleId,
      deploymentTargets: Global.deploymentTargets,
      infoPlist: .extendingDefault(
        with: [
          "UILaunchScreen": [
            "UIColorName": "",
            "UIImageName": "",
          ],
        ]
      ),
      sources: ["../\(name)/\(TargetType.executable)/**"],
      dependencies: dependencies,
      settings: SubTargetBuildSettingsFactory().make()
    )
  }
}
