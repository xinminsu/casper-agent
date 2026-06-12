# @suxinmin/plugin-casper Integration Guide

## Overview
This project has successfully integrated the `@suxinmin/plugin-casper` plugin to enhance the ElizaOS agent's functionality.

## Completed Configuration

### 1. package.json
Added to dependencies:
```json
"@suxinmin/plugin-casper": "latest"
```

### 2. character.ts
Added conditional loading in the character's plugins array:
```typescript
// Casper plugin
...(process.env.CASPER_ENABLED?.trim() === 'true' ? ['@suxinmin/plugin-casper'] : []),
```

### 3. Environment Variable Configuration
- Added example configuration in `.env.example`
- Enabled plugin in `.env`: `CASPER_ENABLED=true`

## Usage

### Enable Plugin
Make sure to set in `.env` file:
```env
CASPER_ENABLED=true
```

### Disable Plugin
To disable the plugin, set:
```env
CASPER_ENABLED=false
```
or remove the line.

## Install Dependencies

Run the following command to install the newly added plugin:
```bash
bun install
# or
npm install
```

## Notes

1. The plugin will be dynamically loaded based on the `CASPER_ENABLED` environment variable
2. The plugin is loaded before the Bootstrap plugin to ensure correct priority
3. TypeScript type check errors are due to dependencies not being installed yet; running `bun install` will resolve them

## Next Steps

1. Install dependencies: `bun install` or `npm install`
2. Start agent: `bun run start` or `npm run start`
3. Verify the plugin loads and runs correctly

## Troubleshooting

If the plugin doesn't load correctly:
1. Check if `CASPER_ENABLED=true` is set in `.env` file
2. Confirm `@suxinmin/plugin-casper` is correctly installed in node_modules
3. Check startup logs for plugin loading information
