# Debug script for Casper plugin TEXT_LARGE error (PowerShell)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Casper Plugin Debug Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check .env file
if (-Not (Test-Path ".env")) {
    Write-Host "❌ Error: .env file not found" -ForegroundColor Red
    exit 1
}

Write-Host "1. Checking environment variables..." -ForegroundColor White
Write-Host "----------------------------------------" -ForegroundColor Gray

# Check OPENROUTER_API_KEY
$envContent = Get-Content ".env" -Raw
if ($envContent -match "OPENROUTER_API_KEY=.+" -and $envContent -notmatch "^OPENROUTER_API_KEY=$") {
    Write-Host "✅ OPENROUTER_API_KEY is set" -ForegroundColor Green
} else {
    Write-Host "❌ OPENROUTER_API_KEY is NOT set or empty" -ForegroundColor Red
    Write-Host "   This is required for LLM processing" -ForegroundColor Yellow
}

# Check CASPER_ENABLED
if ($envContent -match "CASPER_ENABLED=true") {
    Write-Host "✅ CASPER_ENABLED is set to true" -ForegroundColor Green
} else {
    Write-Host "⚠️  CASPER_ENABLED is not set to true" -ForegroundColor Yellow
}

# Check CASPER_API_KEY (optional)
if ($envContent -match "CASPER_API_KEY=.+" -and $envContent -notmatch "^CASPER_API_KEY=$") {
    Write-Host "✅ CASPER_API_KEY is set" -ForegroundColor Green
} else {
    Write-Host "ℹ️  CASPER_API_KEY is not set (may be optional)" -ForegroundColor Cyan
}

Write-Host ""
Write-Host "2. Checking plugin configuration..." -ForegroundColor White
Write-Host "----------------------------------------" -ForegroundColor Gray

# Check if character.ts has correct plugin order
$characterContent = Get-Content "src/character.ts" -Raw
if ($characterContent -match "@elizaos/plugin-openrouter") {
    Write-Host "✅ OpenRouter plugin is configured" -ForegroundColor Green
    
    # Check order
    $openrouterLine = (Select-String -Path "src/character.ts" -Pattern "@elizaos/plugin-openrouter" | Select-Object -First 1).LineNumber
    $casperLine = (Select-String -Path "src/character.ts" -Pattern "@suxinmin/plugin-casper" | Select-Object -First 1).LineNumber
    
    if ($openrouterLine -and $casperLine) {
        if ($openrouterLine -lt $casperLine) {
            Write-Host "✅ Plugin loading order is correct (OpenRouter before Casper)" -ForegroundColor Green
        } else {
            Write-Host "❌ Plugin loading order is WRONG (Casper before OpenRouter)" -ForegroundColor Red
        }
    }
} else {
    Write-Host "❌ OpenRouter plugin not found in configuration" -ForegroundColor Red
}

if ($characterContent -match "@suxinmin/plugin-casper") {
    Write-Host "✅ Casper plugin is configured" -ForegroundColor Green
} else {
    Write-Host "❌ Casper plugin not found in configuration" -ForegroundColor Red
}

Write-Host ""
Write-Host "3. Checking package.json..." -ForegroundColor White
Write-Host "----------------------------------------" -ForegroundColor Gray

$packageContent = Get-Content "package.json" -Raw
if ($packageContent -match "@suxinmin/plugin-casper") {
    Write-Host "✅ Casper plugin is in package.json dependencies" -ForegroundColor Green
} else {
    Write-Host "❌ Casper plugin not found in package.json" -ForegroundColor Red
}

if ($packageContent -match "@elizaos/plugin-openrouter") {
    Write-Host "✅ OpenRouter plugin is in package.json dependencies" -ForegroundColor Green
} else {
    Write-Host "❌ OpenRouter plugin not found in package.json" -ForegroundColor Red
}

Write-Host ""
Write-Host "4. Checking node_modules..." -ForegroundColor White
Write-Host "----------------------------------------" -ForegroundColor Gray

if (Test-Path "node_modules/@suxinmin/plugin-casper") {
    Write-Host "✅ Casper plugin is installed in node_modules" -ForegroundColor Green
} else {
    Write-Host "❌ Casper plugin is NOT installed" -ForegroundColor Red
    Write-Host "   Run: npm install @suxinmin/plugin-casper" -ForegroundColor Yellow
}

if (Test-Path "node_modules/@elizaos/plugin-openrouter") {
    Write-Host "✅ OpenRouter plugin is installed in node_modules" -ForegroundColor Green
} else {
    Write-Host "❌ OpenRouter plugin is NOT installed" -ForegroundColor Red
    Write-Host "   Run: npm install @elizaos/plugin-openrouter" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "5. Checking plugin.ts model handlers..." -ForegroundColor White
Write-Host "----------------------------------------" -ForegroundColor Gray

$pluginContent = Get-Content "src/plugin.ts" -Raw
if ($pluginContent -match "TEXT_LARGE") {
    Write-Host "✅ TEXT_LARGE model handler exists in plugin.ts" -ForegroundColor Green
} else {
    Write-Host "⚠️  TEXT_LARGE model handler not found in plugin.ts" -ForegroundColor Yellow
}

if ($pluginContent -match "TEXT_SMALL") {
    Write-Host "✅ TEXT_SMALL model handler exists in plugin.ts" -ForegroundColor Green
} else {
    Write-Host "⚠️  TEXT_SMALL model handler not found in plugin.ts" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Next Steps" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "To debug the TEXT_LARGE error:" -ForegroundColor White
Write-Host ""
Write-Host "1. Start agent with debug logging:" -ForegroundColor White
Write-Host "   `$env:LOG_LEVEL='debug'; bun run start" -ForegroundColor Cyan
Write-Host ""
Write-Host "2. Look for these messages in logs:" -ForegroundColor White
Write-Host "   - 'Loading plugin: @elizaos/plugin-openrouter'" -ForegroundColor Gray
Write-Host "   - 'Plugin @elizaos/plugin-openrouter initialized'" -ForegroundColor Gray
Write-Host "   - 'Loading plugin: @suxinmin/plugin-casper'" -ForegroundColor Gray
Write-Host ""
Write-Host "3. If OpenRouter is not loading, check:" -ForegroundColor White
Write-Host "   - OPENROUTER_API_KEY is correctly set" -ForegroundColor Gray
Write-Host "   - No errors during plugin initialization" -ForegroundColor Gray
Write-Host ""
Write-Host "4. If issue persists, try:" -ForegroundColor White
Write-Host "   - Updating plugins: bun update" -ForegroundColor Gray
Write-Host "   - Reinstalling: Remove-Item -Recurse -Force node_modules; bun install" -ForegroundColor Gray
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
