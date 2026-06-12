# @suxinmin/plugin-casper 集成说明

## 概述
本项目已成功集成 `@suxinmin/plugin-casper` 插件，用于增强 ElizaOS agent 的功能。

## 已完成的配置

### 1. package.json
已在依赖中添加：
```json
"@suxinmin/plugin-casper": "latest"
```

### 2. character.ts
已在角色配置的 plugins 数组中添加条件加载：
```typescript
// Casper plugin
...(process.env.CASPER_ENABLED?.trim() === 'true' ? ['@suxinmin/plugin-casper'] : []),
```

### 3. 环境变量配置
- `.env.example` 中添加了示例配置
- `.env` 中已启用插件：`CASPER_ENABLED=true`

## 使用方法

### 启用插件
确保在 `.env` 文件中设置：
```env
CASPER_ENABLED=true
```

### 禁用插件
如需禁用插件，设置：
```env
CASPER_ENABLED=false
```
或删除该行。

## 安装依赖

运行以下命令安装新添加的插件：
```bash
bun install
# 或
npm install
```

## 注意事项

1. 插件会根据 `CASPER_ENABLED` 环境变量的值动态加载
2. 插件位于 Bootstrap 插件之前加载，确保优先级正确
3. TypeScript 类型检查错误是因为依赖尚未安装，运行 `bun install` 后会解决

## 下一步

1. 安装依赖：`bun install` 或 `npm install`
2. 启动 agent：`bun run start` 或 `npm run start`
3. 验证插件是否正确加载和运行

## 故障排除

如果插件未正确加载：
1. 检查 `.env` 文件中 `CASPER_ENABLED=true` 是否设置
2. 确认 `@suxinmin/plugin-casper` 已正确安装在 node_modules 中
3. 查看启动日志中是否有插件加载相关的信息
