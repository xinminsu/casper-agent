# Casper RPC Configuration Guide

## Problem Solved

The error `authorization is not provided` with code `7979` indicates that the Casper plugin is trying to connect to a Casper blockchain RPC node but lacks proper authentication or configuration.

## Solution: Configure Casper RPC

You need to add Casper RPC configuration to your `.env` file. There are three options:

### Option 1: Public Testnet RPC (Easiest - Recommended for Testing)

Add these lines to your `.env` file:

```env
# Casper Plugin Configuration
CASPER_ENABLED=true
CASPER_RPC_URL=https://rpc.testnet.cspr.cloud/rpc
CASPER_NETWORK=testnet
```

**Pros:**
- No API key required
- Quick setup
- Perfect for testing and development

**Cons:**
- Rate limited
- May be slower during peak times
- Not suitable for production

### Option 2: Private RPC with Authentication (Recommended for Production)

If you have a private RPC endpoint (e.g., from Casper Cloud, BlockPI, or your own node):

```env
# Casper Plugin Configuration
CASPER_ENABLED=true
CASPER_RPC_URL=https://your-private-rpc-endpoint.com/rpc
CASPER_RPC_API_KEY=your_api_key_here
CASPER_NETWORK=testnet  # or mainnet
```

**Pros:**
- Higher rate limits
- Better performance
- More reliable
- Suitable for production

**Cons:**
- Requires API key
- May have costs associated

**Where to get API keys:**
- [Casper Cloud](https://cloud.cspr.cloud/)
- [BlockPI Network](https://blockpi.io/)
- Run your own Casper node

### Option 3: Local Node (For Advanced Users)

If you're running a local Casper node:

```env
# Casper Plugin Configuration
CASPER_ENABLED=true
CASPER_RPC_URL=http://localhost:7777/rpc
CASPER_NETWORK=testnet  # or mainnet
```

**Pros:**
- Full control
- No rate limits
- Maximum privacy

**Cons:**
- Requires running a Casper node
- Higher resource requirements
- More complex setup

## Available Casper Networks

### Testnet (Recommended for Development)
```env
CASPER_NETWORK=testnet
CASPER_RPC_URL=https://rpc.testnet.cspr.cloud/rpc
```

### Mainnet (For Production)
```env
CASPER_NETWORK=mainnet
CASPER_RPC_URL=https://rpc.cspr.cloud/rpc
```

## Complete Configuration Example

Here's a complete `.env` configuration for Casper:

```env
# ============================================
# Casper Plugin Configuration
# ============================================

# Enable/disable the Casper plugin
CASPER_ENABLED=true

# Network selection (testnet or mainnet)
CASPER_NETWORK=testnet

# RPC endpoint URL
CASPER_RPC_URL=https://rpc.testnet.cspr.cloud/rpc

# Optional: API key for authenticated RPC endpoints
# CASPER_RPC_API_KEY=your_api_key_here

# Optional: Custom timeout in milliseconds (default: 30000)
# CASPER_RPC_TIMEOUT=30000

# Optional: Maximum retries for failed requests (default: 3)
# CASPER_RPC_MAX_RETRIES=3
```

## Troubleshooting

### Error: "authorization is not provided"

**Cause:** Missing or incorrect RPC configuration

**Solution:**
1. Ensure `CASPER_RPC_URL` is set in `.env`
2. Verify the URL is correct for your network
3. If using authenticated RPC, ensure `CASPER_RPC_API_KEY` is set

### Error: "Connection refused" or "Network error"

**Cause:** RPC endpoint is unreachable

**Solution:**
1. Check if the RPC URL is correct
2. Verify your internet connection
3. Try a different RPC endpoint
4. Check if the network (testnet/mainnet) matches the RPC URL

### Error: "Rate limit exceeded"

**Cause:** Too many requests to public RPC

**Solution:**
1. Switch to a private RPC with API key
2. Reduce request frequency
3. Implement caching in your application

### Wallet Creation Still Fails

If you've configured RPC correctly but wallet creation still fails:

1. **Check plugin initialization logs:**
   ```bash
   LOG_LEVEL=debug bun run start
   ```

2. **Look for these messages:**
   - `Loading plugin: @suxinmin/plugin-casper`
   - `Casper plugin initialized successfully`
   - `Connected to Casper network: testnet`

3. **Verify OpenRouter is working:**
   The Casper plugin needs an LLM provider to process commands. Ensure OpenRouter is configured:
   ```env
   OPENROUTER_API_KEY=your_key_here
   ```

## Testing Your Configuration

After updating `.env`, restart your agent:

```bash
# Stop the current agent (Ctrl+C)

# Restart with new configuration
bun run start
```

Then try creating a wallet again:
```
Create a new Casper wallet
```

You should see:
- ✅ No "authorization is not provided" errors
- ✅ Successful wallet generation
- ✅ Wallet address displayed in response

## Additional Resources

- [Casper Network Documentation](https://docs.casper.network/)
- [Casper Cloud RPC](https://cloud.cspr.cloud/)
- [Casper JS SDK](https://github.com/casper-ecosystem/casper-js-sdk)

## Need Help?

If you're still experiencing issues:

1. Run the debug script:
   ```bash
   ./debug-casper.sh  # Linux/Mac
   # or
   .\debug-casper.ps1  # Windows
   ```

2. Check the full logs with debug level:
   ```bash
   LOG_LEVEL=debug bun run start 2>&1 | grep -i casper
   ```

3. Verify your configuration:
   ```bash
   bun run verify:casper
   ```

---

**Last Updated:** 2026-06-12
**Status:** ✅ Configuration guide created
