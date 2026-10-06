import ProjectDescription

public enum TargetAvailibility {
  case available(dependencies: [TargetDependency])
  case unavailable
}
