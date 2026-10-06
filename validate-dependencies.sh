#!/bin/bash

# TuistPOC Dependency Validator
# Checks that main targets only depend on .contract targets

echo "🔍 Validating module dependencies..."
echo ""

VIOLATIONS=0

for project_file in $(find . -name "Project.swift" -type f ! -path "./.*" ! -path "*/.build/*" ! -path "*/.git/*"); do
    # Get the module name and path
    MODULE_NAME=$(basename $(dirname "$project_file"))
    MODULE_PATH=$(dirname "$project_file")

    # Check if file contains .impl in dependencies
    if grep "\.impl" "$project_file" > /dev/null; then
        # Extract the dependencies section (from "dependencies:" to the closing bracket)
        DEPS_SECTION=$(sed -n '/^  dependencies: \[/,/^  \]/p' "$project_file")

        # Check if .impl appears in dependencies (not in executableAvailability or other params)
        if echo "$DEPS_SECTION" | grep -q "\.impl"; then
            echo "❌ DEPENDENCY VIOLATION: $MODULE_NAME"
            echo "   Location: $MODULE_PATH/Project.swift"
            echo "   Issue: Main target cannot depend on .impl (implementation)"
            echo "   Rule: Use .contract (interface) dependencies only"
            echo ""
            VIOLATIONS=$((VIOLATIONS + 1))
        fi
    fi
done

echo ""
if [ $VIOLATIONS -eq 0 ]; then
    echo "✅ All dependencies valid - ready to generate"
    exit 0
else
    echo "❌ Found $VIOLATIONS dependency violation(s) - fix before running tuist generate"
    exit 1
fi
