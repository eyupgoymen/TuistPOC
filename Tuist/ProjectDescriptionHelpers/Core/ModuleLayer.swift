import Foundation

public enum ModuleLayer: String, Codable {
  case core
  case domain
  case feature

  public var description: String {
    switch self {
    case .core:
      return "Core — No module dependencies. Can only depend on external packages."
    case .domain:
      return "Domain — Can depend on Core. No Domain or Feature dependencies."
    case .feature:
      return "Feature — Can depend on Core and Domain."
    }
  }
}
