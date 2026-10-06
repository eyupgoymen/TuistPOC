import ProjectDescription

let workspace = Workspace(
  name: "TuistPOC",
  projects: [
    ".",
    "Core/NetworkingKit",
    "Core/UtilKit",
    "Domain/ProductDomain",
    "Feature/ProductList",
    "Feature/ProductListDetail"
  ]
)
