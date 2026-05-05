$iconCache = "$env:LOCALAPPDATA\IconCache.db"

if (-not (Test-Path $iconCache)) {
    Write-Host "Icon cache has already been deleted."
    exit
}

Write-Host "Attempting to delete icon cache..."
Stop-Process -Name explorer -Force
Remove-Item $iconCache -Force
Write-Host "Icon cache deleted. Restarting Explorer..."
Start-Process explorer.exe
