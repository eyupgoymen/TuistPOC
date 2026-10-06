import ProjectDescription
import ProjectDescriptionHelpers

private let nameAttribute: Template.Attribute = .required("name")
private let directoryAttribute: Template.Attribute = .required("directory")
private let moduleTypeAttribute: Template.Attribute = .required("module-type")
private let layerTypeAttribute: Template.Attribute = .required("layer-type")
private let contractAvailabilityAttribute: Template.Attribute = .required("contract-available")
private let resourcesAvailabilityAttribute: Template.Attribute = .optional("resources-available", default: "false")
private let unitTestsAvailabilityAttribute: Template.Attribute = .required("unit-tests-available")
private let executableAvailabilityAttribute: Template.Attribute = .optional("executable-available", default: "false")
private let mockSupportAvailabilityAttribute: Template.Attribute = .required("mock-support-available")

let moduleTemplate = Template(
  description: "A project template for a new module (library or framework).",
  attributes: [
    nameAttribute,
    directoryAttribute,
    moduleTypeAttribute,
    layerTypeAttribute,
    contractAvailabilityAttribute,
    resourcesAvailabilityAttribute,
    unitTestsAvailabilityAttribute,
    executableAvailabilityAttribute,
    mockSupportAvailabilityAttribute,
  ],
  items: [
    .file(
      path: "\(directoryAttribute)/\(nameAttribute)/\(TargetType.source)/\(nameAttribute).swift",
      templatePath: "Source.stencil"
    ),
    .file(
      path: "\(directoryAttribute)/\(nameAttribute)/\(TargetType.contract)/\(nameAttribute)Contract.swift",
      templatePath: "ContractSource.stencil"
    ),
    .file(
      path: "\(directoryAttribute)/\(nameAttribute)/\(TargetType.mockSupport)/\(nameAttribute)MockSupport.swift",
      templatePath: "MockSupportSource.stencil"
    ),
    .file(
      path: "\(directoryAttribute)/\(nameAttribute)/\(TargetType.resource)/Empty.swift",
      templatePath: "Resource.stencil"
    ),
    .file(
      path: "\(directoryAttribute)/\(nameAttribute)/\(TargetType.executable)/\(nameAttribute)App.swift",
      templatePath: "Executable.stencil"
    ),
    .file(
      path: "\(directoryAttribute)/\(nameAttribute)/\(TargetType.test)/\(nameAttribute)Test.swift",
      templatePath: "Test.stencil"
    ),
    .file(
      path: "\(directoryAttribute)/\(nameAttribute)/Project.swift",
      templatePath: "Project.stencil"
    ),
    .file(
      path: "Tuist/ProjectDescriptionHelpers/Dependencies/\(nameAttribute)Dependency.swift",
      templatePath: "Dependency.stencil"
    ),
  ]
)
