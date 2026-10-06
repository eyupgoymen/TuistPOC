import ProjectDescription

// MARK: - BuildConfigurationBuilder
final class BuildConfigurationBuilder {
  private var buildConfiguration: [Configuration] = []
  private var debugSettings: SettingsDictionary = [:]
  private var releaseSettings: SettingsDictionary = [:]

  @discardableResult
  func register(configuration: (some BuildConfiguration).Type) -> Self {
    let configuration = configuration.init()
    debugSettings[configuration.key] = SettingValue(stringLiteral: configuration.debugValue)
    releaseSettings[configuration.key] = SettingValue(stringLiteral: configuration.releaseValue)
    return self
  }

  func build() -> [Configuration] {
    let debugConfiguration = Configuration.debug(
      name: "Debug",
      settings: debugSettings
    )
    let releaseConfiguration = Configuration.release(
      name: "Release",
      settings: releaseSettings
    )
    
    buildConfiguration.append(debugConfiguration)
    buildConfiguration.append(releaseConfiguration)
    return buildConfiguration
  }
}
