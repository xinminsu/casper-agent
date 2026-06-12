# Casper Plugin Integration - Windows Quick Start Script (PowerShell)

Write-Host "======================================" -ForegroundColor Cyan
Write-Host "  Casper Plugin Integration - Quick Start" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
Write-Host ""

# Check .env file
if (-Not (Test-Path ".env")) {
    Write-Host "❌ Error: .env file does not exist" -ForegroundColor Red
    Write-Host "Please copy .env.example to .env and configure necessary environment variables" -ForegroundColor Yellow
    exit 1
}

# Check CASPER_ENABLED
$envContent = Get-Content ".env" -Raw
if ($envContent -match "CASPER_ENABLED=true") {
    Write-Host "✅ Casper plugin is enabled" -ForegroundColor Green
} else {
    Write-Host "⚠️  Warning: Casper plugin is not enabled" -ForegroundColor Yellow
    Write-Host "Add to .env file: CASPER_ENABLED=true" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Step 1: Installing dependencies..." -ForegroundColor White
Write-Host "--------------------------------------" -ForegroundColor Gray

# Check if bun exists
if (Get-Command bun -ErrorAction SilentlyContinue) {
    Write-Host "Using Bun to install dependencies..." -ForegroundColor Green
    bun install @suxinmin/plugin-casper
} elseif (Get-Command npm -ErrorAction SilentlyContinue) {
    Write-Host "Using NPM to install dependencies..." -ForegroundColor Green
    npm install @suxinmin/plugin-casper
} else {
    Write-Host "❌ Error: bun or npm not found" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "Step 2: Verifying configuration..." -ForegroundColor White
Write-Host "--------------------------------------" -ForegroundColor Gray

if (Get-Command bun -ErrorAction SilentlyContinue) {
    bun run verify-casper-config.ts
} elseif (Get-Command npx -ErrorAction SilentlyContinue) {
    npx tsx verify-casper-config.ts
} else {
    Write-Host "Skipping verification (requires bun or tsx)" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Step 3: Starting Agent..." -ForegroundColor White
Write-Host "--------------------------------------" -ForegroundColor Gray
Write-Host "Run the following command to start agent:" -ForegroundColor White
Write-Host ""
Write-Host "  bun run start" -ForegroundColor Cyan
Write-Host "  or" -ForegroundColor White
Write-Host "  npm run start" -ForegroundColor Cyan
Write-Host ""
Write-Host "======================================" -ForegroundColor Cyan
Write-Host "  Complete!" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
