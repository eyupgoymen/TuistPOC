import ProjectDescription

public enum ModuleType {
  case library
  case framework(hasResources: Bool = false)
}

public struct ModuleProjectFactory {
  public static func make(
    name: String,
    moduleType: ModuleType,
    layer: ModuleLayer,
    excludedSources: [String] = [],
    additionalFiles: [String] = [],
    unitTestAvailability: TargetAvailibility,
    executableAvailability: TargetAvailibility = .unavailable,
    mockSupportAvailability: TargetAvailibility,
    contractAvailability: TargetAvailibility,
    dependencies: [TargetDependency]
  ) -> Project {
    var targets: [Target] = .empty

    let moduleTarget = makeTarget(
      name: name,
      moduleType: moduleType,
      dependencies: dependencies,
      excludedSources: excludedSources,
      additionalFiles: additionalFiles
    )
    targets.append(moduleTarget)

    if !ProductConfig.isReleaseMode {
      if case let .available(testDependencies) = unitTestAvailability {
        let testTarget = TestTargetFactory().make(
          name: name,
          dependencies: testDependencies
        )
        targets.append(testTarget)
      }

      if case let .available(executableDependencies) = executableAvailability {
        let executableTarget = ExecutableTargetFactory().make(
          name: name,
          dependencies: executableDependencies
        )
        targets.append(executableTarget)
      }

      if case let .available(mockSupportDependencies) = mockSupportAvailability {
        let mockSupportTarget = MockSupportTargetFactory().make(
          name: name,
          dependencies: mockSupportDependencies
        )
        targets.append(mockSupportTarget)
      }
    }

    if case let .available(contractDependencies) = contractAvailability {
      let contractTarget = ContractTargetFactory().make(
        name: name,
        dependencies: contractDependencies
      )
      targets.append(contractTarget)
    }

    return Project(
      name: name,
      targets: targets
    )
  }

  private static func makeTarget(
    name: String,
    moduleType: ModuleType,
    dependencies: [TargetDependency],
    excludedSources: [String],
    additionalFiles: [String]
  ) -> Target {
    let bundleId = String(
      format: "%@.%@",
      Global.bundleIdentifierPrefix, name
    ).lowercased()

    let mainDirectory = "../\(name)/\(TargetType.source)"

    let (product, resourcePath): (Product, ResourceFileElements?) = switch moduleType {
    case .library:
      (ProductConfig.libraryProduct, nil)
    case .framework(let hasResources):
      (ProductConfig.frameworkProduct, hasResources ? "../\(name)/\(TargetType.resource)/**" : nil)
    }

    let additionalFiles: [FileElement] = additionalFiles.map {
      return .folderReference(path: "\(mainDirectory)/\($0)")
    }

    let excludedSources: [Path] = excludedSources.map {
      return "\(mainDirectory)/\($0)"
    }

    return Target.target(
      name: name,
      destinations: Global.destionations,
      product: product,
      bundleId: bundleId,
      deploymentTargets: Global.deploymentTargets,
      infoPlist: .default,
      sources: .sourceFilesList(
        globs: [
          .glob("\(mainDirectory)/**", excluding: excludedSources)
        ]
      ),
      resources: resourcePath,
      dependencies: dependencies,
      settings: SubTargetBuildSettingsFactory().make(),
      additionalFiles: additionalFiles
    )
  }
}
