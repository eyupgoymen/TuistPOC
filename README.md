# TuistPOC

A proof-of-concept Tuist infrastructure project demonstrating modular architecture with layered dependencies.

## Setup

```bash
# Install dependencies
tuist install

# Generate Xcode project
tuist generate

# Safe generation (validates architecture before generating)
./tuist-safe-generate.sh
```

## Common Commands

```bash
# Generate entire workspace
tuist generate

# Generate specific module
tuist generate NetworkingKit
tuist generate ProductList
tuist generate ProductListDetail

# Generate multiple modules
tuist generate NetworkingKit ProductList

# Clean generated files and caches
tuist clean

# Clear Tuist cache
tuist cache clean

# Run tests for all modules
tuist test

# Run tests for specific module
tuist test NetworkingKit
tuist test ProductList
```

## Scaffolding New Modules

Create a new module using the ModuleTemplate. The template automatically generates the module structure with source, test, contract, and mock support targets.

### Example: Create a new Feature module

```bash
tuist scaffold ModuleTemplate \
  --name PaymentFeature \
  --directory Feature \
  --module-type framework \
  --layer-type feature \
  --contract-available yes \
  --unit-tests-available yes \
  --executable-available yes \
  --mock-support-available yes
```

### Example: Create a new Core module

```bash
tuist scaffold ModuleTemplate \
  --name StorageKit \
  --directory Core \
  --module-type library \
  --layer-type core \
  --contract-available yes \
  --unit-tests-available yes \
  --executable-available no \
  --mock-support-available yes
```

### Template Attributes

- `name`: Module name (e.g., PaymentFeature, StorageKit)
- `directory`: Layer directory (Core, Domain, Feature)
- `module-type`: library or framework
- `layer-type`: core, domain, or feature
- `contract-available`: yes/no (creates interface target)
- `resources-available`: yes/no (framework resources)
- `unit-tests-available`: yes/no
- `executable-available`: yes/no (runnable app)
- `mock-support-available`: yes/no (mock target)

## Architecture Validation

The project enforces layered architecture rules:

- **Core**: Cannot depend on other modules
- **Domain**: Can only depend on Core
- **Feature**: Can depend on Core and Domain, but not other Feature modules

Validation runs automatically with `tuist-safe-generate.sh` and blocks generation if violations are detected.

```bash
# Validate layers manually
./validate-layers.sh

# Validate dependencies manually
./validate-dependencies.sh

# Run all validations
./validate.sh
```

## Release Mode

Build for release using the TUIST_RELEASE_MODE environment variable. In release mode, test, mock, and executable targets are excluded from the build.

```bash
# Generate for release
TUIST_RELEASE_MODE=1 tuist generate

# Clean and regenerate for release
tuist clean && TUIST_RELEASE_MODE=1 tuist generate
```

## Project Structure

```
TuistPOC/
├── Core/              # Core layer modules (no dependencies)
│   ├── NetworkingKit/
│   └── UtilKit/
├── Domain/            # Domain layer modules (depend on Core)
│   └── ProductDomain/
├── Feature/           # Feature layer modules (depend on Core/Domain)
│   ├── ProductList/
│   └── ProductListDetail/
├── Tuist/
│   ├── ProjectDescriptionHelpers/  # Shared factories and helpers
│   └── Templates/ModuleTemplate/   # Scaffolding template
└── validate-*.sh      # Architecture validation scripts
```

## Tests

Each module includes unit tests. Run tests selectively:

```bash
# All tests
tuist test

# Specific module
tuist test Feature/ProductList

# Specific test target
tuist test ProductListTests
```
