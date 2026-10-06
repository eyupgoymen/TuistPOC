#!/bin/sh

# TuistPOC Complete Validator
# Runs all validation checks before build

echo "🔍 Running TuistPOC validation suite..."
echo ""

FAILED=0

# Run dependency validation
echo "1️⃣  Checking dependencies..."
if ./validate-dependencies.sh; then
    :
else
    FAILED=1
fi

echo ""

# Run layer validation
echo "2️⃣  Checking architectural layers..."
if ./validate-layers.sh; then
    :
else
    FAILED=1
fi

echo ""
echo "════════════════════════════════════════════════════════════════"

if [ $FAILED -eq 0 ]; then
    echo "✅ All validations passed - ready to generate"
    exit 0
else
    echo "❌ Some validations failed - please fix issues above"
    exit 1
fi
