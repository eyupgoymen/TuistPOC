import ProjectDescription

struct TargetDependencyProvider {
  private let name: String
  private let directory: String

  private var basePath: Path {
    return .relativeToRoot("\(directory)/\(name)")
  }
  
  var implTarget: TargetDependency {
    return .project(
      target: name,
      path: basePath
    )
  }

  var contractTarget: TargetDependency {
    return .project(
      target: name + TargetType.contract,
      path: basePath
    )
  }

  var mockSupportTarget: TargetDependency {
    return .project(
      target: name + TargetType.mockSupport,
      path: basePath
    )
  }
  
  init(name: String, directory: String) {
    self.name = name
    self.directory = directory
  }
}
