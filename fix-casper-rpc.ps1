# Quick fix script for Casper RPC authorization error (PowerShell)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Fixing Casper RPC Configuration" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if .env exists
if (-Not (Test-Path ".env")) {
    Write-Host "❌ Error: .env file not found" -ForegroundColor Red
    exit 1
}

Write-Host "Current Casper configuration:" -ForegroundColor White
Write-Host "----------------------------------------" -ForegroundColor Gray
Get-Content ".env" | Select-String "CASPER_" | ForEach-Object { Write-Host $_ }
if (-not (Get-Content ".env" | Select-String "CASPER_")) {
    Write-Host "No Casper configuration found" -ForegroundColor Yellow
}
Write-Host ""

# Check if CASPER_RPC_URL is already set
$envContent = Get-Content ".env" -Raw
if ($envContent -match "^CASPER_RPC_URL=.+" ) {
    Write-Host "✅ CASPER_RPC_URL is already configured" -ForegroundColor Green
    Write-Host ""
    Write-Host "Current RPC URL:" -ForegroundColor White
    Get-Content ".env" | Select-String "^CASPER_RPC_URL=" | ForEach-Object { Write-Host $_ -ForegroundColor Cyan }
} else {
    Write-Host "⚠️  CASPER_RPC_URL is missing or empty" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Adding default Casper testnet RPC configuration..." -ForegroundColor White
    Write-Host "" | Out-File -FilePath ".env" -Append
    Write-Host "# Casper RPC Configuration - Added by fix script" | Out-File -FilePath ".env" -Append
    Write-Host "CASPER_RPC_URL=https://rpc.testnet.cspr.cloud/rpc" | Out-File -FilePath ".env" -Append
    Write-Host "CASPER_NETWORK=testnet" | Out-File -FilePath ".env" -Append
    Write-Host ""
    Write-Host "✅ Configuration added to .env" -ForegroundColor Green
}

Write-Host ""
Write-Host "Updated Casper configuration:" -ForegroundColor White
Write-Host "----------------------------------------" -ForegroundColor Gray
Get-Content ".env" | Select-String "CASPER_" | ForEach-Object { Write-Host $_ }
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Next Steps" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Restart your agent:" -ForegroundColor White
Write-Host "   bun run start" -ForegroundColor Cyan
Write-Host ""
Write-Host "2. Try creating a wallet again:" -ForegroundColor White
Write-Host "   Create a new Casper wallet" -ForegroundColor Cyan
Write-Host ""
Write-Host "If you still see errors, check:" -ForegroundColor White
Write-Host "- OPENROUTER_API_KEY is set correctly" -ForegroundColor Gray
Write-Host "- Your internet connection" -ForegroundColor Gray
Write-Host "- The RPC endpoint is accessible" -ForegroundColor Gray
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
