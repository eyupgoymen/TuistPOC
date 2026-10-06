#!/bin/sh

# TuistPOC Layer Architecture Validator
# Dynamically discovers modules and enforces layer rules

echo "🏗️  Validating architectural layers..."
echo ""

VIOLATIONS_FILE="/tmp/tuist_violations_$$"
> "$VIOLATIONS_FILE"

# Dynamically discover modules from directory structure
get_layer() {
    local module=$1
    if [ -d "./Core/$module" ]; then
        echo "core"
    elif [ -d "./Domain/$module" ]; then
        echo "domain"
    elif [ -d "./Feature/$module" ]; then
        echo "feature"
    else
        echo "unknown"
    fi
}

# Get all modules
get_all_modules() {
    (
        [ -d "./Core" ] && find ./Core -maxdepth 1 -type d ! -name "Core" -exec basename {} \;
        [ -d "./Domain" ] && find ./Domain -maxdepth 1 -type d ! -name "Domain" -exec basename {} \;
        [ -d "./Feature" ] && find ./Feature -maxdepth 1 -type d ! -name "Feature" -exec basename {} \;
    ) | sort -u
}

# Convert camelCase to proper case
normalize_name() {
    # productDomain -> ProductDomain, productList -> ProductList
    local name=$1
    local first=$(echo "$name" | cut -c1)
    local rest=$(echo "$name" | cut -c2-)
    echo "$(echo "$first" | tr 'a-z' 'A-Z')$rest"
}

can_depend_on() {
    local dependent=$1
    local dependency=$2

    # Can't depend on itself
    if [ "$dependent" = "$dependency" ]; then
        return 0
    fi

    local module_layer=$(get_layer "$dependent")
    local dep_layer=$(get_layer "$dependency")

    # Unknown dependencies are external (allowed)
    if [ "$dep_layer" = "unknown" ]; then
        return 0
    fi

    case "$module_layer" in
        core)
            # Core can't depend on any modules
            return 1
            ;;
        domain)
            # Domain can only depend on Core
            if [ "$dep_layer" != "core" ]; then
                return 1
            fi
            ;;
        feature)
            # Feature can't depend on other Feature modules
            if [ "$dep_layer" = "feature" ]; then
                return 1
            fi
            ;;
    esac

    return 0
}

# Check each module
for module in $(get_all_modules); do
    module_layer=$(get_layer "$module")

    if [ "$module_layer" = "unknown" ]; then
        continue
    fi

    project_file=$(find . -path "*/$module/Project.swift" -type f ! -path "./.*" ! -path "*/.build/*" 2>/dev/null | head -1)

    if [ -z "$project_file" ]; then
        continue
    fi

    # Extract module names from dependencies (camelCase pattern)
    # Matches: moduleName.contract or moduleName.impl
    grep -oE '[a-z][a-zA-Z]*\.(contract|impl)' "$project_file" | sed -e 's/\.contract$//' -e 's/\.impl$//' | sort -u | while read -r dep_lower; do
        dep=$(normalize_name "$dep_lower")

        # Skip if module doesn't exist (external)
        if [ "$(get_layer "$dep")" = "unknown" ]; then
            continue
        fi

        if ! can_depend_on "$module" "$dep"; then
            dep_layer=$(get_layer "$dep")
            echo "❌ LAYER VIOLATION: $module ($module_layer)"
            echo "   └─ Cannot depend on $dep ($dep_layer)"
            echo "   └─ Location: $project_file"
            echo ""
            echo "violation" >> "$VIOLATIONS_FILE"
        fi
    done
done

echo ""
VIOLATIONS=$(wc -l < "$VIOLATIONS_FILE" | tr -d ' ')
rm -f "$VIOLATIONS_FILE"

if [ "$VIOLATIONS" -eq 0 ]; then
    echo "✅ All layers follow architecture rules"
    echo ""
    echo "📋 Discovered modules:"

    for dir in Core Domain Feature; do
        if [ -d "./$dir" ]; then
            case "$dir" in
                Core) symbol="🔵" ;;
                Domain) symbol="🟢" ;;
                Feature) symbol="🟡" ;;
            esac
            modules=$(find "./$dir" -maxdepth 1 -type d ! -name "$dir" -exec basename {} \; | tr '\n' ',' | sed 's/,$//')
            if [ -n "$modules" ]; then
                echo "   $symbol $dir: $modules"
            fi
        fi
    done

    exit 0
else
    echo "❌ Found $VIOLATIONS layer violation(s)"
    exit 1
fi
