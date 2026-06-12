# Casper Plugin TEXT_LARGE Error Fix

## Problem

When using the Casper plugin and inputting "Create a new Casper wallet", you get this error:

```
Error #Eliza [SERVICE:MESSAGE] Error processing message (error=No handler found for delegate type: TEXT_LARGE)
Error [SERVICE:MESSAGE-BUS] Error processing message via handleMessage (error=No handler found for delegate type: TEXT_LARGE)
```

## Root Cause

The Casper plugin (`@suxinmin/plugin-casper`) is trying to process messages but doesn't have a `TEXT_LARGE` model handler registered. This can happen when:

1. The Casper plugin expects to use an LLM provider's model handler but can't find it
2. The plugin loading order is incorrect
3. The Casper plugin itself needs to provide model handlers

## Solutions

### Solution 1: Ensure LLM Provider is Loaded First (Recommended)

The current configuration already loads OpenRouter before Casper, which is correct. However, verify that OpenRouter is actually being loaded:

**Check your `.env` file:**
```env
OPENROUTER_API_KEY=
OPENROUTER_SMALL_MODEL=deepseek/deepseek-v4-pro
OPENROUTER_LARGE_MODEL=deepseek/deepseek-v4-pro
OPENROUTER_EMBEDDING_MODEL=openai/text-embedding-3-small
```

**Verify in startup logs:**
Look for these messages when starting the agent:
- `Loading plugin: @elizaos/plugin-openrouter`
- `Plugin @elizaos/plugin-openrouter initialized successfully`

### Solution 2: Add Model Handlers to Starter Plugin

If the Casper plugin still can't find the model handler, you can add explicit model handlers to your local `plugin.ts` file as a fallback:

The current `src/plugin.ts` already has model handlers defined (lines 216-236), but they're just example implementations. You might need to ensure these are properly registered.

### Solution 3: Check Casper Plugin Requirements

The Casper plugin might have specific requirements. Check:

1. **Does it need specific environment variables?**
   ```env
   CASPER_API_KEY=your_api_key_here
   CASPER_NETWORK=testnet  # or mainnet
   ```

2. **Does it require a specific plugin version?**
   Update to the latest version:
   ```bash
   npm update @suxinmin/plugin-casper
   # or
   bun update @suxinmin/plugin-casper
   ```

### Solution 4: Debug Plugin Loading Order

Add logging to verify plugin loading order:

1. Check the agent startup logs
2. Verify that `@elizaos/plugin-openrouter` loads BEFORE `@suxinmin/plugin-casper`
3. Look for any errors during plugin initialization

## Quick Fix Steps

1. **Restart the agent with verbose logging:**
   ```bash
   LOG_LEVEL=debug bun run start
   ```

2. **Check the logs for:**
   - Plugin loading sequence
   - Any errors related to model handlers
   - Casper plugin initialization messages

3. **Verify OpenRouter is working:**
   Try a simple message without Casper-specific commands to ensure the LLM provider is working correctly.

4. **Test Casper command again:**
   Once you confirm OpenRouter is working, try the "Create a new Casper wallet" command again.

## Alternative: Temporarily Disable Casper Plugin

If you need to test other functionality while debugging:

```env
# In .env file
CASPER_ENABLED=false
```

Then restart the agent.

## Expected Behavior

After fixing, you should see:
- No `TEXT_LARGE` handler errors
- Casper plugin successfully processes wallet creation commands
- Proper responses from the agent

## Additional Debugging

If the issue persists, check:

1. **Casper plugin documentation** for specific setup requirements
2. **GitHub issues** for `@suxinmin/plugin-casper` for known problems
3. **ElizaOS version compatibility** - ensure the plugin is compatible with your ElizaOS version (1.7.2)

## Contact

If none of these solutions work, consider:
- Opening an issue on the Casper plugin repository
- Checking ElizaOS community forums
- Reviewing the plugin's source code for model handler requirements
