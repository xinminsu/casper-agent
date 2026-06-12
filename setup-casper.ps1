# Casper 插件集成 - Windows 快速启动脚本 (PowerShell)

Write-Host "======================================" -ForegroundColor Cyan
Write-Host "  Casper 插件集成 - 快速启动" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
Write-Host ""

# 检查 .env 文件
if (-Not (Test-Path ".env")) {
    Write-Host "❌ 错误: .env 文件不存在" -ForegroundColor Red
    Write-Host "请复制 .env.example 到 .env 并配置必要的环境变量" -ForegroundColor Yellow
    exit 1
}

# 检查 CASPER_ENABLED
$envContent = Get-Content ".env" -Raw
if ($envContent -match "CASPER_ENABLED=true") {
    Write-Host "✅ Casper 插件已启用" -ForegroundColor Green
} else {
    Write-Host "⚠️  警告: Casper 插件未启用" -ForegroundColor Yellow
    Write-Host "在 .env 文件中添加: CASPER_ENABLED=true" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "步骤 1: 安装依赖..." -ForegroundColor White
Write-Host "--------------------------------------" -ForegroundColor Gray

# 检查是否有 bun
if (Get-Command bun -ErrorAction SilentlyContinue) {
    Write-Host "使用 Bun 安装依赖..." -ForegroundColor Green
    bun install @suxinmin/plugin-casper
} elseif (Get-Command npm -ErrorAction SilentlyContinue) {
    Write-Host "使用 NPM 安装依赖..." -ForegroundColor Green
    npm install @suxinmin/plugin-casper
} else {
    Write-Host "❌ 错误: 未找到 bun 或 npm" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "步骤 2: 验证配置..." -ForegroundColor White
Write-Host "--------------------------------------" -ForegroundColor Gray

if (Get-Command bun -ErrorAction SilentlyContinue) {
    bun run verify-casper-config.ts
} elseif (Get-Command npx -ErrorAction SilentlyContinue) {
    npx tsx verify-casper-config.ts
} else {
    Write-Host "跳过验证（需要 bun 或 tsx）" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "步骤 3: 启动 Agent..." -ForegroundColor White
Write-Host "--------------------------------------" -ForegroundColor Gray
Write-Host "运行以下命令启动 agent:" -ForegroundColor White
Write-Host ""
Write-Host "  bun run start" -ForegroundColor Cyan
Write-Host "  或" -ForegroundColor White
Write-Host "  npm run start" -ForegroundColor Cyan
Write-Host ""
Write-Host "======================================" -ForegroundColor Cyan
Write-Host "  完成！" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
