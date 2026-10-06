#!/bin/sh

# TuistPOC Safe Generation Wrapper
# Prevents generation if validation fails

echo "🛡️  TuistPOC Safe Generate"
echo ""

# Run validation first
if ! ./validate.sh; then
    echo ""
    echo "🚫 Generation blocked - validation failed"
    echo "   Fix the issues above and try again"
    exit 1
fi

echo ""
echo "✅ Validation passed - proceeding with generation..."
echo ""

# Run tuist generate
tuist generate

exit $?
