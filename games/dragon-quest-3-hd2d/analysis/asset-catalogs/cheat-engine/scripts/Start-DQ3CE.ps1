# Start-DQ3CE.ps1
# Dragon Quest III HD-2D Remake - Cheat Engine launcher

<#
.SYNOPSIS
    Launches Dragon Quest III HD-2D with Cheat Engine integration.

.DESCRIPTION
    This script provides a convenient way to start DQ3 with CE automation.
    It can optionally start the game, then launch CE with your cheat tables.

.PARAMETER StartGame
    If specified, will start the game before launching CE

.PARAMETER LoadTable
    If specified, will load a cheat table into CE

.PARAMETER TableName
    Name of the table to load (master, gold, items, etc.)
    Defaults to "master"

.EXAMPLE
    .\Start-DQ3CE.ps1 -LoadTable
    Launches CE with master.CT table (assumes game is already running)

.EXAMPLE
    .\Start-DQ3CE.ps1 -StartGame -LoadTable -TableName "gold"
    Starts the game, then launches CE with dq3-gold.CT
#>

param(
    [Parameter(Mandatory=$false)]
    [switch]$StartGame,

    [Parameter(Mandatory=$false)]
    [switch]$LoadTable,

    [Parameter(Mandatory=$false)]
    [string]$TableName = "master"
)

# Configuration
$script:Config = @{
    ProcessName = "DQIIIHD2DRemake.exe"
    GamePath = "C:\Program Files (x86)\Steam\steamapps\common\DRAGON QUEST III HD-2D Remake\Game\Binaries\Win64\DQIIIHD2DRemake.exe"
    CEPath = "C:\Program Files\Cheat Engine 7.6\cheatengine-x86_64.exe"
    TablesDir = "D:\Dev\GitHub\GameDumps\games\dragon-quest-3-hd2d\analysis\asset-catalogs\cheat-engine\dq3-tables"
    DataDir = "D:\Dev\GitHub\GameDumps\games\dragon-quest-3-hd2d\analysis\asset-catalogs\cheat-engine"
}

Write-Host "=== Dragon Quest III HD-2D Remake - CE Launcher ===" -ForegroundColor Yellow
Write-Host ""

# Function: Check if game is running
function Test-GameRunning {
    $processName = $script:Config.ProcessName -replace '\.exe$', ''
    $process = Get-Process -Name $processName -ErrorAction SilentlyContinue
    return $process
}

# Function: Start the game
function Start-DQ3Game {
    Write-Host "[1/3] Starting Dragon Quest III HD-2D..." -ForegroundColor Cyan

    if (-not (Test-Path $script:Config.GamePath)) {
        Write-Error "Game not found at: $($script:Config.GamePath)"
        Write-Host "Please update the GamePath in this script"
        return $false
    }

    Start-Process -FilePath $script:Config.GamePath
    Write-Host "  Game launched" -ForegroundColor Green

    Write-Host "  Waiting for game to initialize..." -ForegroundColor White
    $timeout = 30
    $elapsed = 0

    while ($elapsed -lt $timeout) {
        Start-Sleep -Seconds 1
        $elapsed++

        if (Test-GameRunning) {
            Write-Host "  Game process detected!" -ForegroundColor Green
            Start-Sleep -Seconds 3  # Extra time for game to fully load
            return $true
        }
    }

    Write-Warning "Game did not start within $timeout seconds"
    return $false
}

# Function: Launch Cheat Engine
function Start-CheatEngine {
    param([string]$TablePath)

    Write-Host "`n[2/3] Launching Cheat Engine..." -ForegroundColor Cyan

    if (-not (Test-Path $script:Config.CEPath)) {
        Write-Error "Cheat Engine not found at: $($script:Config.CEPath)"
        return $false
    }

    if ($TablePath) {
        if (Test-Path $TablePath) {
            Start-Process -FilePath $script:Config.CEPath -ArgumentList "`"$TablePath`""
            Write-Host "  CE launched with table: $(Split-Path $TablePath -Leaf)" -ForegroundColor Green
        }
        else {
            Write-Warning "Table not found: $TablePath"
            Start-Process -FilePath $script:Config.CEPath
            Write-Host "  CE launched without table" -ForegroundColor Yellow
        }
    }
    else {
        Start-Process -FilePath $script:Config.CEPath
        Write-Host "  CE launched" -ForegroundColor Green
    }

    Start-Sleep -Seconds 2
    return $true
}

# Function: Show available data files
function Show-GameData {
    Write-Host "`n[3/3] Available game data:" -ForegroundColor Cyan

    $jsonFiles = Get-ChildItem -Path $script:Config.DataDir -Filter "*.json" -ErrorAction SilentlyContinue

    if ($jsonFiles) {
        Write-Host "  Extracted data files in asset-catalogs/cheat-engine/:" -ForegroundColor White
        foreach ($file in $jsonFiles) {
            $size = if ($file.Length -gt 1MB) {
                "{0:N2} MB" -f ($file.Length / 1MB)
            } else {
                "{0:N0} KB" -f ($file.Length / 1KB)
            }
            Write-Host "    - $($file.Name) ($size)" -ForegroundColor Gray
        }
    }
}

# Main execution
try {
    # Step 1: Ensure game is running
    if ($StartGame) {
        $gameStarted = Start-DQ3Game
        if (-not $gameStarted) {
            Write-Error "Failed to start game"
            exit 1
        }
    }
    else {
        Write-Host "[1/3] Checking if game is running..." -ForegroundColor Cyan
        $gameProcess = Test-GameRunning

        if (-not $gameProcess) {
            Write-Warning "Game is not running!"
            Write-Host "`nOptions:"
            Write-Host "  1. Start the game manually, then run this script again"
            Write-Host "  2. Run this script with -StartGame parameter"
            exit 1
        }

        Write-Host "  Game found (PID: $($gameProcess.Id))" -ForegroundColor Green
    }

    # Step 2: Launch CE with optional table
    $tablePath = $null
    if ($LoadTable) {
        $tablePath = Join-Path $script:Config.TablesDir "dq3-$TableName.CT"

        # Fallback to master if specific table not found
        if (-not (Test-Path $tablePath)) {
            Write-Warning "Table 'dq3-$TableName.CT' not found, trying master.CT..."
            $tablePath = Join-Path $script:Config.TablesDir "master.CT"
        }
    }

    $ceStarted = Start-CheatEngine -TablePath $tablePath
    if (-not $ceStarted) {
        Write-Error "Failed to start Cheat Engine"
        exit 1
    }

    # Step 3: Show game data info
    Show-GameData

    # Instructions
    Write-Host "`n=== Next Steps ===" -ForegroundColor Yellow
    Write-Host "1. In Cheat Engine, click the computer icon (top-left)"
    Write-Host "2. Select '$($script:Config.ProcessName)' from the process list"
    Write-Host "3. Click 'Open' to attach"
    if ($LoadTable) {
        Write-Host "4. Enable cheats by checking boxes in the address list"
        Write-Host "5. Reference GOP_Item.json, GOP_Monster.json for item/enemy IDs"
    }

    Write-Host "`n=== Ready! ===" -ForegroundColor Green
}
catch {
    Write-Error "An error occurred: $_"
    exit 1
}
