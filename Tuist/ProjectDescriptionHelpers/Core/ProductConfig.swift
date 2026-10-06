import Foundation
import ProjectDescription

public enum ProductConfig {
  public static var isReleaseMode: Bool {
    Environment.isReleaseMode.getBoolean(default: false)
  }

  public static var frameworkProduct: Product {
    isReleaseMode ? .staticFramework : .framework
  }

  public static var contructProduct: Product {
    isReleaseMode ? .staticLibrary : .framework
  }

  public static var libraryProduct: Product {
    isReleaseMode ? .staticLibrary : .framework
  }

  public static var mockSupportProduct: Product {
    isReleaseMode ? .staticLibrary : .framework
  }

  public static var packageProduct: Product {
    isReleaseMode ? .staticLibrary : .framework
  }
}
