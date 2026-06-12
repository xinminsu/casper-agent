#!/bin/bash
# Casper 插件集成 - 快速启动脚本

echo "======================================"
echo "  Casper 插件集成 - 快速启动"
echo "======================================"
echo ""

# 检查 .env 文件
if [ ! -f .env ]; then
    echo "❌ 错误: .env 文件不存在"
    echo "请复制 .env.example 到 .env 并配置必要的环境变量"
    exit 1
fi

# 检查 CASPER_ENABLED
if grep -q "CASPER_ENABLED=true" .env; then
    echo "✅ Casper 插件已启用"
else
    echo "⚠️  警告: Casper 插件未启用"
    echo "在 .env 文件中添加: CASPER_ENABLED=true"
fi

echo ""
echo "步骤 1: 安装依赖..."
echo "--------------------------------------"

# 检查是否有 bun
if command -v bun &> /dev/null; then
    echo "使用 Bun 安装依赖..."
    bun install @suxinmin/plugin-casper
elif command -v npm &> /dev/null; then
    echo "使用 NPM 安装依赖..."
    npm install @suxinmin/plugin-casper
else
    echo "❌ 错误: 未找到 bun 或 npm"
    exit 1
fi

echo ""
echo "步骤 2: 验证配置..."
echo "--------------------------------------"

if command -v bun &> /dev/null; then
    bun run verify-casper-config.ts
elif command -v npx &> /dev/null; then
    npx tsx verify-casper-config.ts
else
    echo "跳过验证（需要 bun 或 tsx）"
fi

echo ""
echo "步骤 3: 启动 Agent..."
echo "--------------------------------------"
echo "运行以下命令启动 agent:"
echo ""
echo "  bun run start"
echo "  或"
echo "  npm run start"
echo ""
echo "======================================"
echo "  完成！"
echo "======================================"
