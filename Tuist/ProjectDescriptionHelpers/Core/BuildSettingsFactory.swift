import ProjectDescription

// MARK: - MainTargetBuildSettingsFactory
public struct MainTargetBuildSettingsFactory {
  public init() {}
  
  public func make() -> Settings {
    let configurations = BuildConfigurationBuilder()
      .register(configuration: AppIconConfiguration.self)
      .register(configuration: BundleIdConfiguration.self)
      .register(configuration: CloudContainerConfiguration.self)
      .register(configuration: ApproachableConcurrencyConfiguration.self)
      .register(configuration: DefaultActorIsolationConfiguration.self)
      .register(configuration: SwiftVersionConfiguration.self)
      .register(configuration: StrictConcurrencyConfiguration.self)
      .register(configuration: SigningStyleConfiguration.self)
      .register(configuration: DevelopmentTeamConfiguration.self)
      .build()

    return .settings(
      base: [:],
      configurations: configurations
    )
  }
}

// MARK: - SubTargetBuildSettingsFactory
public struct SubTargetBuildSettingsFactory {
  public init() {}
  
  public func make() -> Settings {
    let configurations = BuildConfigurationBuilder()
      .register(configuration: ApproachableConcurrencyConfiguration.self)
      .register(configuration: DefaultActorIsolationConfiguration.self)
      .register(configuration: SwiftVersionConfiguration.self)
      .register(configuration: StrictConcurrencyConfiguration.self)
      .build()
    
    return .settings(
      base: [:],
      configurations: configurations
    )
  }
}

// MARK: - BuildConfiguration
protocol BuildConfiguration {
  var key: String { get }
  var debugValue: String { get }
  var releaseValue: String { get }
  
  init()
}

struct BundleIdConfiguration: BuildConfiguration {
  var key: String {
    return "PRODUCT_BUNDLE_IDENTIFIER"
  }
  
  var debugValue: String {
    return "com.appspector.main.debug"
  }
  
  var releaseValue: String {
    return "com.appspector.main"
  }
}

struct AppIconConfiguration: BuildConfiguration {
  var key: String {
    return "ASSETCATALOG_COMPILER_APPICON_NAME"
  }
  
  var debugValue: String {
    return "AppIcon-Debug"
  }
  
  var releaseValue: String {
    return "AppIcon"
  }
}

struct CloudContainerConfiguration: BuildConfiguration {
  var key: String {
    return "ICLOUD_CONTAINER"
  }
  
  var debugValue: String {
    return "iCloud.com.appspector.main.debug"
  }
  
  var releaseValue: String {
    return "iCloud.com.appspector.main"
  }
}

struct ApproachableConcurrencyConfiguration: BuildConfiguration {
  var key: String {
    return "SWIFT_APPROACHABLE_CONCURRENCY"
  }
  
  var debugValue: String {
    return "true"
  }
  
  var releaseValue: String {
    return "true"
  }
}

struct StrictConcurrencyConfiguration: BuildConfiguration {
  var key: String {
    return "SWIFT_STRICT_CONCURRENCY"
  }
  
  var debugValue: String {
    return "complete"
  }
  
  var releaseValue: String {
    return "minimal"
  }
}

struct DefaultActorIsolationConfiguration: BuildConfiguration {
  var key: String {
    return "SWIFT_DEFAULT_ACTOR_ISOLATION"
  }
  
  var debugValue: String {
    return "nonisolated"
  }
  
  var releaseValue: String {
    return "nonisolated"
  }
}

struct SwiftVersionConfiguration: BuildConfiguration {
  var key: String {
    return "SWIFT_VERSION"
  }
  
  var debugValue: String {
    return Global.swiftVersion
  }
  
  var releaseValue: String {
    return Global.swiftVersion
  }
}

struct SigningStyleConfiguration: BuildConfiguration {
  var key: String {
    return "CODE_SIGN_STYLE"
  }
  
  var debugValue: String {
    return "Automatic"
  }
  
  var releaseValue: String {
    return "Automatic"
  }
}

struct DevelopmentTeamConfiguration: BuildConfiguration {
  var key: String {
    return "DEVELOPMENT_TEAM"
  }
  
  var debugValue: String {
    return "Automatic"
  }
  
  var releaseValue: String {
    return "Automatic"
  }
}
