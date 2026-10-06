import ProjectDescription

private enum PlistKey {
  static var appVersion: String { "CFBundleShortVersionString" }
  static var buildNumber: String { "CFBundleVersion" }
  static var applicationCategoryType: String { "LSApplicationCategoryType" }
  static var exemptEncryption: String { "ITSAppUsesNonExemptEncryption" }
}

public struct InfoPlistFactory {
  public init() {}
  
  public func make() -> InfoPlist {
    .extendingDefault(with: [
      PlistKey.appVersion: Global.version,
      PlistKey.buildNumber: Global.buildNumber,
      PlistKey.applicationCategoryType: Global.applicationCategory,
      PlistKey.exemptEncryption: false,
    ])
  }
}
