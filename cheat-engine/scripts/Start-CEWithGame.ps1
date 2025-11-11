# Start-CEWithGame.ps1
# Generic launcher for Cheat Engine with any game process

<#
.SYNOPSIS
    Launches Cheat Engine and optionally loads a cheat table.

.DESCRIPTION
    This script checks if a game process is running, then launches Cheat Engine
    with an optional cheat table file.

.PARAMETER ProcessName
    The name of the game process (e.g., "GameName.exe")

.PARAMETER TablePath
    Optional path to a .CT cheat table file to load

.PARAMETER CEPath
    Path to Cheat Engine executable (defaults to standard install location)

.EXAMPLE
    .\Start-CEWithGame.ps1 -ProcessName "DQIIIHD2DRemake.exe" -TablePath "C:\tables\dq3.CT"

.EXAMPLE
    .\Start-CEWithGame.ps1 -ProcessName "Game.exe"
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$ProcessName,

    [Parameter(Mandatory=$false)]
    [string]$TablePath,

    [Parameter(Mandatory=$false)]
    [string]$CEPath = "C:\Program Files\Cheat Engine 7.6\cheatengine-x86_64.exe"
)

# Check if CE exists
if (-not (Test-Path $CEPath)) {
    Write-Error "Cheat Engine not found at: $CEPath"
    Write-Host "Please update the -CEPath parameter or install CE to the default location"
    exit 1
}

# Remove .exe extension if present for process check
$processBaseName = $ProcessName -replace '\.exe$', ''

# Check if game process is running
Write-Host "Checking for game process: $ProcessName" -ForegroundColor Cyan
$gameProcess = Get-Process -Name $processBaseName -ErrorAction SilentlyContinue

if (-not $gameProcess) {
    Write-Warning "Game process not found: $ProcessName"
    Write-Host "`nPlease start the game first, then run this script again."
    exit 1
}

Write-Host "  Game found (PID: $($gameProcess.Id))" -ForegroundColor Green

# Check table path if provided
if ($TablePath) {
    if (-not (Test-Path $TablePath)) {
        Write-Warning "Cheat table not found: $TablePath"
        Write-Host "Launching CE without table..."
        $TablePath = $null
    }
    else {
        Write-Host "  Table found: $(Split-Path $TablePath -Leaf)" -ForegroundColor Green
    }
}

# Launch Cheat Engine
Write-Host "`nLaunching Cheat Engine..." -ForegroundColor Cyan

if ($TablePath) {
    Start-Process -FilePath $CEPath -ArgumentList "`"$TablePath`""
    Write-Host "  CE launched with table: $(Split-Path $TablePath -Leaf)" -ForegroundColor Green
}
else {
    Start-Process -FilePath $CEPath
    Write-Host "  CE launched" -ForegroundColor Green
}

# Wait for CE to start
Start-Sleep -Seconds 2

# Instructions
Write-Host "`n=== Next Steps ===" -ForegroundColor Yellow
Write-Host "1. In Cheat Engine, click the computer icon (top-left)"
Write-Host "2. Select '$ProcessName' from the process list"
Write-Host "3. Click 'Open' to attach to the game"
if ($TablePath) {
    Write-Host "4. Enable cheats by checking boxes in the address list"
}
Write-Host "`nReady!" -ForegroundColor Green
