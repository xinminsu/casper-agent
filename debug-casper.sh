#!/bin/bash
# Debug script for Casper plugin TEXT_LARGE error

echo "========================================"
echo "  Casper Plugin Debug Script"
echo "========================================"
echo ""

# Check .env file
if [ ! -f .env ]; then
    echo "❌ Error: .env file not found"
    exit 1
fi

echo "1. Checking environment variables..."
echo "----------------------------------------"

# Check OPENROUTER_API_KEY
if grep -q "OPENROUTER_API_KEY=" .env && ! grep -q "^OPENROUTER_API_KEY=$" .env; then
    echo "✅ OPENROUTER_API_KEY is set"
else
    echo "❌ OPENROUTER_API_KEY is NOT set or empty"
    echo "   This is required for LLM processing"
fi

# Check CASPER_ENABLED
if grep -q "CASPER_ENABLED=true" .env; then
    echo "✅ CASPER_ENABLED is set to true"
else
    echo "⚠️  CASPER_ENABLED is not set to true"
fi

# Check CASPER_RPC_URL (Critical)
if grep -q "CASPER_RPC_URL=" .env && ! grep -q "^CASPER_RPC_URL=$" .env; then
    echo "✅ CASPER_RPC_URL is set"
    RPC_URL=$(grep "CASPER_RPC_URL=" .env | head -1 | cut -d'=' -f2-)
    echo "   URL: $RPC_URL"
else
    echo "❌ CASPER_RPC_URL is NOT set or empty"
    echo "   This is REQUIRED for Casper blockchain interaction"
    echo "   Add to .env: CASPER_RPC_URL=https://rpc.testnet.cspr.cloud/rpc"
fi

# Check CASPER_NETWORK
if grep -q "CASPER_NETWORK=" .env && ! grep -q "^CASPER_NETWORK=$" .env; then
    NETWORK=$(grep "CASPER_NETWORK=" .env | head -1 | cut -d'=' -f2-)
    echo "✅ CASPER_NETWORK is set to: $NETWORK"
else
    echo "⚠️  CASPER_NETWORK is not set (defaulting to testnet)"
fi

# Check CASPER_RPC_API_KEY (optional)
if grep -q "CASPER_RPC_API_KEY=" .env && ! grep -q "^CASPER_RPC_API_KEY=$" .env; then
    echo "✅ CASPER_RPC_API_KEY is set (authenticated RPC)"
else
    echo "ℹ️  CASPER_RPC_API_KEY is not set (using public RPC)"
fi

echo ""
echo "2. Checking plugin configuration..."
echo "----------------------------------------"

# Check if character.ts has correct plugin order
if grep -A 30 "plugins:" src/character.ts | grep -q "@elizaos/plugin-openrouter"; then
    echo "✅ OpenRouter plugin is configured"
    
    # Check order
    OPENROUTER_LINE=$(grep -n "@elizaos/plugin-openrouter" src/character.ts | head -1 | cut -d: -f1)
    CASPER_LINE=$(grep -n "@suxinmin/plugin-casper" src/character.ts | head -1 | cut -d: -f1)
    
    if [ -n "$OPENROUTER_LINE" ] && [ -n "$CASPER_LINE" ]; then
        if [ "$OPENROUTER_LINE" -lt "$CASPER_LINE" ]; then
            echo "✅ Plugin loading order is correct (OpenRouter before Casper)"
        else
            echo "❌ Plugin loading order is WRONG (Casper before OpenRouter)"
        fi
    fi
else
    echo "❌ OpenRouter plugin not found in configuration"
fi

if grep -q "@suxinmin/plugin-casper" src/character.ts; then
    echo "✅ Casper plugin is configured"
else
    echo "❌ Casper plugin not found in configuration"
fi

echo ""
echo "3. Checking package.json..."
echo "----------------------------------------"

if grep -q "@suxinmin/plugin-casper" package.json; then
    echo "✅ Casper plugin is in package.json dependencies"
else
    echo "❌ Casper plugin not found in package.json"
fi

if grep -q "@elizaos/plugin-openrouter" package.json; then
    echo "✅ OpenRouter plugin is in package.json dependencies"
else
    echo "❌ OpenRouter plugin not found in package.json"
fi

echo ""
echo "4. Checking node_modules..."
echo "----------------------------------------"

if [ -d "node_modules/@suxinmin/plugin-casper" ]; then
    echo "✅ Casper plugin is installed in node_modules"
else
    echo "❌ Casper plugin is NOT installed"
    echo "   Run: npm install @suxinmin/plugin-casper"
fi

if [ -d "node_modules/@elizaos/plugin-openrouter" ]; then
    echo "✅ OpenRouter plugin is installed in node_modules"
else
    echo "❌ OpenRouter plugin is NOT installed"
    echo "   Run: npm install @elizaos/plugin-openrouter"
fi

echo ""
echo "5. Checking plugin.ts model handlers..."
echo "----------------------------------------"

if grep -q "TEXT_LARGE" src/plugin.ts; then
    echo "✅ TEXT_LARGE model handler exists in plugin.ts"
else
    echo "⚠️  TEXT_LARGE model handler not found in plugin.ts"
fi

if grep -q "TEXT_SMALL" src/plugin.ts; then
    echo "✅ TEXT_SMALL model handler exists in plugin.ts"
else
    echo "⚠️  TEXT_SMALL model handler not found in plugin.ts"
fi

echo ""
echo "========================================"
echo "  Next Steps"
echo "========================================"
echo ""
echo "To debug the TEXT_LARGE error:"
echo ""
echo "1. Start agent with debug logging:"
echo "   LOG_LEVEL=debug bun run start"
echo ""
echo "2. Look for these messages in logs:"
echo "   - 'Loading plugin: @elizaos/plugin-openrouter'"
echo "   - 'Plugin @elizaos/plugin-openrouter initialized'"
echo "   - 'Loading plugin: @suxinmin/plugin-casper'"
echo ""
echo "3. If OpenRouter is not loading, check:"
echo "   - OPENROUTER_API_KEY is correctly set"
echo "   - No errors during plugin initialization"
echo ""
echo "4. If issue persists, try:"
echo "   - Updating plugins: bun update"
echo "   - Clearing cache: rm -rf node_modules && bun install"
echo ""
echo "========================================"
