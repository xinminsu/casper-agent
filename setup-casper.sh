#!/bin/bash
# Casper Plugin Integration - Quick Start Script

echo "======================================"
echo "  Casper Plugin Integration - Quick Start"
echo "======================================"
echo ""

# Check .env file
if [ ! -f .env ]; then
    echo "❌ Error: .env file does not exist"
    echo "Please copy .env.example to .env and configure necessary environment variables"
    exit 1
fi

# Check CASPER_ENABLED
if grep -q "CASPER_ENABLED=true" .env; then
    echo "✅ Casper plugin is enabled"
else
    echo "⚠️  Warning: Casper plugin is not enabled"
    echo "Add to .env file: CASPER_ENABLED=true"
fi

echo ""
echo "Step 1: Installing dependencies..."
echo "--------------------------------------"

# Check if bun exists
if command -v bun &> /dev/null; then
    echo "Using Bun to install dependencies..."
    bun install @suxinmin/plugin-casper
elif command -v npm &> /dev/null; then
    echo "Using NPM to install dependencies..."
    npm install @suxinmin/plugin-casper
else
    echo "❌ Error: bun or npm not found"
    exit 1
fi

echo ""
echo "Step 2: Verifying configuration..."
echo "--------------------------------------"

if command -v bun &> /dev/null; then
    bun run verify-casper-config.ts
elif command -v npx &> /dev/null; then
    npx tsx verify-casper-config.ts
else
    echo "Skipping verification (requires bun or tsx)"
fi

echo ""
echo "Step 3: Starting Agent..."
echo "--------------------------------------"
echo "Run the following command to start agent:"
echo ""
echo "  bun run start"
echo "  or"
echo "  npm run start"
echo ""
echo "======================================"
echo "  Complete!"
echo "======================================"
