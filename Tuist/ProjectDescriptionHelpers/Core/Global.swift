import ProjectDescription

public enum Global {
  public static var appName: String {
    return "TuistPOC"
  }
  
  public static var bundleIdentifierPrefix: String {
    return "com.tuistpocs"
  }
  
  public static var deploymentTargets: DeploymentTargets {
    return .macOS("26.0")
  }
  
  public static var destionations: Destinations {
    return .macOS
  }
  
  public static var mainBundleIdentifier: String {
    return bundleIdentifierPrefix + ".main"
  }
  
  public static var version: Plist.Value {
    return "1.0"
  }
  
  public static var buildNumber: Plist.Value {
    return "0"
  }
  
  public static var applicationCategory: Plist.Value {
    return "public.app-category.developer-tools"
  }
  
  public static var entitlements: Entitlements {
    return "TuistPoc/TuistPoc.entitlements"
  }
  
  public static var developmentTeam: String {
    return "-"
  }
  
  public static var swiftVersion: String {
    return "6.2"
  }
}
