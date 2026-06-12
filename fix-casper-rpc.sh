#!/bin/bash
# Quick fix script for Casper RPC authorization error

echo "========================================"
echo "  Fixing Casper RPC Configuration"
echo "========================================"
echo ""

# Check if .env exists
if [ ! -f .env ]; then
    echo "❌ Error: .env file not found"
    exit 1
fi

echo "Current Casper configuration:"
echo "----------------------------------------"
grep "CASPER_" .env || echo "No Casper configuration found"
echo ""

# Check if CASPER_RPC_URL is already set
if grep -q "^CASPER_RPC_URL=" .env && ! grep -q "^CASPER_RPC_URL=$" .env; then
    echo "✅ CASPER_RPC_URL is already configured"
    echo ""
    echo "Current RPC URL:"
    grep "^CASPER_RPC_URL=" .env
else
    echo "⚠️  CASPER_RPC_URL is missing or empty"
    echo ""
    echo "Adding default Casper testnet RPC configuration..."
    echo "" >> .env
    echo "# Casper RPC Configuration - Added by fix script" >> .env
    echo "CASPER_RPC_URL=https://rpc.testnet.cspr.cloud/rpc" >> .env
    echo "CASPER_NETWORK=testnet" >> .env
    echo ""
    echo "✅ Configuration added to .env"
fi

echo ""
echo "Updated Casper configuration:"
echo "----------------------------------------"
grep "CASPER_" .env
echo ""
echo "========================================"
echo "  Next Steps"
echo "========================================"
echo ""
echo "1. Restart your agent:"
echo "   bun run start"
echo ""
echo "2. Try creating a wallet again:"
echo "   Create a new Casper wallet"
echo ""
echo "If you still see errors, check:"
echo "- OPENROUTER_API_KEY is set correctly"
echo "- Your internet connection"
echo "- The RPC endpoint is accessible"
echo ""
echo "========================================"
