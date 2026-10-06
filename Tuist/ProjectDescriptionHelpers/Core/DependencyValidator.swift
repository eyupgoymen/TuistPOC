import Foundation

public struct DependencyValidator {
  public static func validateInterfaceTargetDependencies(
    targetName: String,
    dependencies: [String]
  ) throws {
    for dep in dependencies {
      if dep.contains(".impl") {
        throw DependencyViolationError.implDependencyNotAllowed(
          target: targetName,
          dependency: dep
        )
      }
    }
  }

  public static func validateTestableTargetDependencies(
    targetName: String,
    moduleName: String,
    dependencies: [String]
  ) throws {
    for dep in dependencies {
      let isOwnModule = isDependencyFromModule(dep, moduleName: moduleName)
      let isImplDep = dep.contains(".impl")

      if isImplDep && !isOwnModule {
        throw DependencyViolationError.implDependencyOnlyOwnModule(
          target: targetName,
          dependency: dep,
          targetType: "test/mock/executable"
        )
      }
    }
  }

  private static func isDependencyFromModule(_ dependency: String, moduleName: String) -> Bool {
    let lowerDep = dependency.lowercased()
    let lowerModule = moduleName.lowercased()
    return lowerDep.starts(with: lowerModule) || lowerDep.contains(".\(lowerModule)")
  }
}

public enum DependencyViolationError: LocalizedError {
  case implDependencyNotAllowed(target: String, dependency: String)
  case implDependencyOnlyOwnModule(target: String, dependency: String, targetType: String)
  case invalidDependencyFormat(target: String, dependency: String)

  public var errorDescription: String? {
    switch self {
    case .implDependencyNotAllowed(let target, let dependency):
      return "❌ Dependency Violation: \(target) cannot depend on implementation '\(dependency)'. Only contract (.contract) dependencies allowed."

    case .implDependencyOnlyOwnModule(let target, let dependency, let type):
      return "❌ Dependency Violation: \(type) target '\(target)' cannot depend on external implementation '\(dependency)'. Only own module's .impl allowed."

    case .invalidDependencyFormat(let target, let dependency):
      return "❌ Dependency Violation: \(target) has invalid dependency format '\(dependency)'. Must be in format 'moduleName' or 'moduleName.contract' or 'moduleName.impl'"
    }
  }
}
