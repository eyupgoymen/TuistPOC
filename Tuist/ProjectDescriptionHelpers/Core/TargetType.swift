import ProjectDescription

public enum TargetType {
  public static var contract: String { return "Contract" }
  public static var executable: String { return "Executable" }
  public static var mockSupport: String { return "MockSupport" }
  public static var resource: String { return "Resource" }
  public static var source: String { return "Source" }
  public static var test: String { return "Test" }
}
