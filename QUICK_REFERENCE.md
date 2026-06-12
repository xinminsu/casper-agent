# Casper Plugin - Quick Reference

## 🚀 Quick Start

### Method 1: Using Automated Script (Recommended)

**Windows (PowerShell):**
```powershell
.\setup-casper.ps1
```

**Linux/Mac:**
```bash
chmod +x setup-casper.sh
./setup-casper.sh
```

### Method 2: Manual Steps

```bash
# 1. Install dependencies
bun install @suxinmin/plugin-casper
# or
npm install @suxinmin/plugin-casper

# 2. Verify configuration
bun run verify:casper

# 3. Start agent
bun run start
```

## 📝 Configuration Files

### Enable/Disable Plugin

Edit `.env` file:
```env
# Enable
CASPER_ENABLED=true

# Disable
CASPER_ENABLED=false
```

### Verify Configuration is Correct

Run verification script:
```bash
bun run verify:casper
```

Will display:
- ✅ CASPER_ENABLED environment variable status
- ✅ Whether plugin is in the loading list
- ✅ Whether configuration is correct

## 🔧 Modified Files

| File | Changes |
|------|---------|
| `package.json` | Added `@suxinmin/plugin-casper` dependency and `verify:casper` script |
| `src/character.ts` | Added conditional loading logic in plugins array |
| `.env` | Set `CASPER_ENABLED=true` |
| `.env.example` | Added Casper configuration description |

## 📂 New Files

| File | Purpose |
|------|------|
| `verify-casper-config.ts` | Configuration verification script |
| `setup-casper.sh` | Linux/Mac auto-installation script |
| `setup-casper.ps1` | Windows auto-installation script |
| `CASPER_PLUGIN_INTEGRATION.md` | Detailed integration documentation |
| `INTEGRATION_SUMMARY.md` | Integration summary documentation |
| `QUICK_REFERENCE.md` | This quick reference |

## ⚙️ Plugin Loading Order

```
1. Core plugins (plugin-sql)
2. LLM providers (anthropic, elizacloud, openrouter...)
3. Platform plugins (discord, twitter, telegram)
4. Casper plugin ← Here
5. Bootstrap plugin
```

## 🐛 Common Issues

### Q: TypeScript errors "Cannot find module"
**A:** Run `bun install` or `npm install` to install dependencies

### Q: Plugin not loading
**Checklist:**
- [ ] `CASPER_ENABLED=true` in `.env`
- [ ] Dependencies installed (`node_modules/@suxinmin/plugin-casper` exists)
- [ ] Plugin configuration exists in `src/character.ts`

### Q: How to confirm plugin is running?
**A:** After starting agent, check logs; you should see plugin loading information

## 📖 Related Documentation

- Detailed integration guide: `CASPER_PLUGIN_INTEGRATION.md`
- Complete summary: `INTEGRATION_SUMMARY.md`
- Project main documentation: `README.md`

## 💡 Tips

1. **First time use**: Run `bun run verify:casper` to confirm configuration is correct
2. **Debugging**: Check plugin loading information in startup logs
3. **Updates**: Regularly run `bun update @suxinmin/plugin-casper` to stay current

---

**Last Updated**: 2026-06-12
