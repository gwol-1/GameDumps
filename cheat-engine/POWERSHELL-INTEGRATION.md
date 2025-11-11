# PowerShell Integration with Cheat Engine

Automate Cheat Engine tasks using PowerShell for advanced workflows.

---

## Overview

While Cheat Engine is primarily GUI-based, there are several ways to interface with it programmatically using PowerShell:

1. **LuaClient Pipe API** - CE's built-in inter-process communication
2. **CEAutoAttach** - Command-line process attachment tool
3. **Lua Script Execution** - Run CE Lua scripts from PowerShell
4. **File-based Communication** - CT file generation and loading

---

## Method 1: LuaClient Pipe API

Cheat Engine's `LuaClient.dll` provides a named pipe API for external programs to communicate with CE.

### How It Works

1. CE opens a Lua server using `openLuaServer(Name)`
2. External programs connect to the named pipe
3. Commands are sent as Lua code
4. CE executes and returns results

### CE Setup (Server Side)

**Create a CE Lua script to open the server:**

```lua
-- In CE: Table > Show Cheat Table Lua Script
-- Add this code:

local serverName = "CEAutomation"

-- Open Lua server
if openLuaServer(serverName) then
  print("Lua server opened: " .. serverName)
  print("External programs can connect to: \\\\.\\pipe\\" .. serverName)
else
  print("Failed to open Lua server")
end

-- Keep server open
function onTableClose()
  closeLuaServer()
end
```

### PowerShell Client

**Connect to CE and send commands:**

```powershell
# PowerShell script to communicate with CE

function Connect-CheatEngine {
    param(
        [string]$ServerName = "CEAutomation"
    )

    $pipePath = "\\.\pipe\$ServerName"

    try {
        $pipe = New-Object System.IO.Pipes.NamedPipeClientStream(".", $ServerName, [System.IO.Pipes.PipeDirection]::InOut)
        $pipe.Connect(5000) # 5 second timeout

        if ($pipe.IsConnected) {
            Write-Host "Connected to Cheat Engine server: $ServerName" -ForegroundColor Green
            return $pipe
        }
    }
    catch {
        Write-Error "Failed to connect to CE: $_"
        return $null
    }
}

function Send-CECommand {
    param(
        [System.IO.Pipes.NamedPipeClientStream]$Pipe,
        [string]$LuaCode
    )

    if (-not $Pipe.IsConnected) {
        Write-Error "Not connected to CE"
        return $null
    }

    try {
        $writer = New-Object System.IO.StreamWriter($Pipe)
        $writer.AutoFlush = $true
        $writer.WriteLine($LuaCode)

        $reader = New-Object System.IO.StreamReader($Pipe)
        $response = $reader.ReadLine()

        return $response
    }
    catch {
        Write-Error "Failed to send command: $_"
        return $null
    }
}

# Example usage
$ce = Connect-CheatEngine
if ($ce) {
    # Get process name
    $result = Send-CECommand -Pipe $ce -LuaCode "return process"
    Write-Host "Current process: $result"

    # Attach to game
    Send-CECommand -Pipe $ce -LuaCode "openProcess('DQIIIHD2DRemake.exe')"

    # Read memory address
    $health = Send-CECommand -Pipe $ce -LuaCode "return readInteger(0x12345678)"
    Write-Host "Health value: $health"

    $ce.Close()
}
```

---

## Method 2: CEAutoAttach Tool

**CEAutoAttach** enables command-line process attachment for CE.

### Installation

1. **Download:** https://github.com/mrexodia/CEAutoAttach
2. **Extract** to CE installation folder
3. **Usage:** Launch CE with process name

### PowerShell Script

```powershell
# Auto-attach CE to game process

$ceExe = "C:\Program Files\Cheat Engine 7.6\cheatengine-x86_64.exe"
$processName = "DQIIIHD2DRemake.exe"
$tableFile = "D:\Dev\GitHub\GameDumps\games\dragon-quest-3-hd2d\analysis\asset-catalogs\cheat-engine\dq3-tables\master.CT"

function Start-CheatEngineWithProcess {
    param(
        [string]$CEPath,
        [string]$ProcessName,
        [string]$TablePath = $null
    )

    # Check if process is running
    $gameProcess = Get-Process -Name ($ProcessName -replace '\.exe$', '') -ErrorAction SilentlyContinue

    if (-not $gameProcess) {
        Write-Warning "Game process not found: $ProcessName"
        Write-Host "Please start the game first"
        return
    }

    Write-Host "Found process: $ProcessName (PID: $($gameProcess.Id))" -ForegroundColor Green

    # Build CE arguments
    $ceArgs = @()

    if ($TablePath -and (Test-Path $TablePath)) {
        $ceArgs += "`"$TablePath`""
        Write-Host "Loading table: $TablePath"
    }

    # Launch CE
    Start-Process -FilePath $CEPath -ArgumentList $ceArgs

    # Wait for CE to start
    Start-Sleep -Seconds 2

    Write-Host "Cheat Engine launched" -ForegroundColor Green
}

# Execute
Start-CheatEngineWithProcess -CEPath $ceExe -ProcessName $processName -TablePath $tableFile
```

---

## Method 3: Lua Script Execution

Execute CE Lua scripts from PowerShell by generating and loading CT files.

### PowerShell: Generate Lua Scripts

```powershell
# Generate CE Lua script from PowerShell

function New-CELuaScript {
    param(
        [string]$OutputPath,
        [string]$ProcessName,
        [hashtable]$Addresses
    )

    $luaScript = @"
-- Auto-generated CE Lua Script
-- Created: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')

-- Auto-attach to process
local processName = "$ProcessName"

if openProcess(processName) then
    print("Attached to " .. processName)

    -- Add addresses to address list
    local al = getAddressList()

"@

    # Add each address
    foreach ($addr in $Addresses.GetEnumerator()) {
        $luaScript += @"

    -- $($addr.Name)
    local mr = al.createMemoryRecord()
    mr.Description = "$($addr.Name)"
    mr.Address = "$($addr.Value.Address)"
    mr.Type = vtDword

"@
    }

    $luaScript += @"

    print("Addresses added successfully")
else
    print("Failed to attach to " .. processName)
end
"@

    $luaScript | Out-File -FilePath $OutputPath -Encoding UTF8
    Write-Host "Lua script created: $OutputPath" -ForegroundColor Green
}

# Example: Generate script for DQ3
$addresses = @{
    "Player Gold" = @{ Address = "0x12345678" }
    "Player Health" = @{ Address = "0x87654321" }
    "Player Level" = @{ Address = "0xABCDEF00" }
}

New-CELuaScript -OutputPath "D:\Dev\GitHub\GameDumps\games\dragon-quest-3-hd2d\analysis\asset-catalogs\cheat-engine\auto-attach.lua" `
                -ProcessName "DQIIIHD2DRemake.exe" `
                -Addresses $addresses
```

---

## Method 4: CT File Generation

Create cheat tables programmatically from PowerShell.

### PowerShell: Generate CT Files

```powershell
# Generate CE Cheat Table from JSON data

function New-CECheatTable {
    param(
        [string]$OutputPath,
        [string]$ProcessName,
        [array]$CheatRecords
    )

    $xml = @"
<?xml version="1.0" encoding="utf-8"?>
<CheatTable CheatEngineTableVersion="42">
  <CheatEntries>
"@

    $id = 0
    foreach ($record in $CheatRecords) {
        $xml += @"

    <CheatEntry>
      <ID>$id</ID>
      <Description>"$($record.Description)"</Description>
      <VariableType>$($record.Type)</VariableType>
      <Address>$($record.Address)</Address>
    </CheatEntry>
"@
        $id++
    }

    $xml += @"

  </CheatEntries>
  <UserdefinedSymbols/>
  <Comments>
    <Comment>Generated from PowerShell on $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')</Comment>
  </Comments>
</CheatTable>
"@

    $xml | Out-File -FilePath $OutputPath -Encoding UTF8
    Write-Host "Cheat table created: $OutputPath" -ForegroundColor Green
}

# Example usage
$records = @(
    @{ Description = "Gold"; Address = "0x12345678"; Type = "4 Bytes" }
    @{ Description = "Health"; Address = "0x87654321"; Type = "4 Bytes" }
)

New-CECheatTable -OutputPath "D:\Dev\GitHub\GameDumps\games\dragon-quest-3-hd2d\analysis\asset-catalogs\cheat-engine\dq3-tables\generated.CT" `
                 -ProcessName "DQIIIHD2DRemake.exe" `
                 -CheatRecords $records
```

---

## Integration with GameDumps Project

### Use Extracted JSON Data

**Example: Generate CE table from GOP_Item.json**

```powershell
# Create item spawner from extracted game data

$jsonPath = "D:\Dev\GitHub\GameDumps\games\dragon-quest-3-hd2d\analysis\asset-catalogs\cheat-engine\GOP_Item.json"
$outputCT = "D:\Dev\GitHub\GameDumps\games\dragon-quest-3-hd2d\analysis\asset-catalogs\cheat-engine\dq3-tables\items-reference.CT"

# Load item data
$itemData = Get-Content $jsonPath | ConvertFrom-Json

# Extract useful items
$records = @()
$itemData.PSObject.Properties | ForEach-Object {
    $item = $_.Value

    if ($item.BuyPrice) {
        $records += @{
            Description = "$($item.SelfId) (Buy: $($item.BuyPrice)G)"
            Address = "PLACEHOLDER"  # Would need to find actual address
            Type = "4 Bytes"
            Notes = "Item ID for spawning"
        }
    }
}

Write-Host "Found $($records.Count) items with prices" -ForegroundColor Cyan

# Generate reference table (without actual addresses yet)
# User would need to find addresses in CE first
```

### Complete Workflow Script

```powershell
# Complete DQ3 CE automation workflow

param(
    [switch]$AutoAttach,
    [switch]$LoadTable,
    [string]$TablePath = "D:\Dev\GitHub\GameDumps\games\dragon-quest-3-hd2d\analysis\asset-catalogs\cheat-engine\dq3-tables\master.CT"
)

$processName = "DQIIIHD2DRemake.exe"
$ceExe = "C:\Program Files\Cheat Engine 7.6\cheatengine-x86_64.exe"

Write-Host "=== Dragon Quest III HD-2D CE Automation ===" -ForegroundColor Yellow

# Step 1: Check if game is running
Write-Host "`n[1/3] Checking if game is running..." -ForegroundColor Cyan
$gameProcess = Get-Process -Name ($processName -replace '\.exe$', '') -ErrorAction SilentlyContinue

if (-not $gameProcess) {
    Write-Warning "Game not found. Please start Dragon Quest III HD-2D first."
    exit
}

Write-Host "  Game found (PID: $($gameProcess.Id))" -ForegroundColor Green

# Step 2: Launch CE with table
if ($LoadTable -and (Test-Path $TablePath)) {
    Write-Host "`n[2/3] Launching Cheat Engine with table..." -ForegroundColor Cyan
    Start-Process -FilePath $ceExe -ArgumentList "`"$TablePath`""
    Write-Host "  CE launched with: $(Split-Path $TablePath -Leaf)" -ForegroundColor Green
} else {
    Write-Host "`n[2/3] Launching Cheat Engine..." -ForegroundColor Cyan
    Start-Process -FilePath $ceExe
    Write-Host "  CE launched" -ForegroundColor Green
}

# Step 3: Instructions
Write-Host "`n[3/3] Next steps:" -ForegroundColor Cyan
Write-Host "  1. In CE, click the computer icon (top-left)"
Write-Host "  2. Select '$processName' from process list"
Write-Host "  3. Click 'Open' to attach"
if ($LoadTable) {
    Write-Host "  4. Enable cheats by checking boxes in address list"
}

Write-Host "`n=== Ready! ===" -ForegroundColor Yellow
```

**Usage:**
```powershell
# Launch CE and load table
.\Start-DQ3CE.ps1 -LoadTable

# Just launch CE
.\Start-DQ3CE.ps1
```

---

## Advanced: Memory Reading from PowerShell

**Direct memory access (requires P/Invoke):**

```powershell
# Read game memory directly from PowerShell (advanced)

Add-Type @"
using System;
using System.Runtime.InteropServices;

public class MemoryReader {
    [DllImport("kernel32.dll")]
    public static extern IntPtr OpenProcess(int dwDesiredAccess, bool bInheritHandle, int dwProcessId);

    [DllImport("kernel32.dll")]
    public static extern bool ReadProcessMemory(IntPtr hProcess, IntPtr lpBaseAddress, byte[] lpBuffer, int dwSize, ref int lpNumberOfBytesRead);

    [DllImport("kernel32.dll")]
    public static extern bool WriteProcessMemory(IntPtr hProcess, IntPtr lpBaseAddress, byte[] lpBuffer, int nSize, ref int lpNumberOfBytesWritten);

    [DllImport("kernel32.dll")]
    public static extern bool CloseHandle(IntPtr hObject);

    public const int PROCESS_VM_READ = 0x0010;
    public const int PROCESS_VM_WRITE = 0x0020;
    public const int PROCESS_VM_OPERATION = 0x0008;
}
"@

function Read-ProcessMemory {
    param(
        [int]$ProcessId,
        [long]$Address,
        [int]$Size = 4
    )

    $handle = [MemoryReader]::OpenProcess(0x0010, $false, $ProcessId)

    if ($handle -eq [IntPtr]::Zero) {
        Write-Error "Failed to open process"
        return $null
    }

    $buffer = New-Object byte[] $Size
    $bytesRead = 0

    $success = [MemoryReader]::ReadProcessMemory($handle, [IntPtr]$Address, $buffer, $Size, [ref]$bytesRead)
    [MemoryReader]::CloseHandle($handle)

    if ($success) {
        return $buffer
    }

    return $null
}

# Example: Read 4 bytes from address
$processId = (Get-Process -Name "DQIIIHD2DRemake").Id
$address = 0x12345678
$bytes = Read-ProcessMemory -ProcessId $processId -Address $address -Size 4

if ($bytes) {
    $value = [BitConverter]::ToInt32($bytes, 0)
    Write-Host "Value at 0x$($address.ToString('X')): $value"
}
```

---

## Best Practices

### ✅ Do:

- **Test on single-player games only**
- **Backup saves** before automation
- **Use error handling** in scripts
- **Document addresses** and offsets
- **Keep CE tables in version control**

### ❌ Don't:

- **Automate multiplayer/online games** (bannable)
- **Run scripts without understanding them**
- **Modify memory without testing first**
- **Share automation scripts for online games**

---

## Project Structure Integration

### Recommended Folder Layout

```
GameDumps/
├── cheat-engine/
│   ├── POWERSHELL-INTEGRATION.md    # This file
│   └── scripts/
│       ├── Start-CEWithGame.ps1     # Generic launcher
│       ├── New-CETable.ps1           # CT generator
│       └── Connect-CEServer.ps1      # LuaClient connection
│
└── games/
    └── dragon-quest-3-hd2d/
        └── analysis/
            └── asset-catalogs/
                └── cheat-engine/
                    ├── scripts/
                    │   ├── Start-DQ3CE.ps1        # Game-specific launcher
                    │   ├── Generate-ItemTable.ps1 # Use GOP_Item.json
                    │   └── auto-attach.lua        # CE Lua auto-attach
                    └── dq3-tables/
                        └── generated/             # Auto-generated tables
```

---

## Example Workflows

### Workflow 1: Quick Game Launch + CE

```powershell
# Quick-start script
$game = "DQIIIHD2DRemake.exe"
$gameDir = "C:\Program Files (x86)\Steam\steamapps\common\DRAGON QUEST III HD-2D Remake"
$table = "D:\Dev\GitHub\GameDumps\games\dragon-quest-3-hd2d\analysis\asset-catalogs\cheat-engine\dq3-tables\master.CT"

# Start game
Start-Process -FilePath (Join-Path $gameDir "Game\Binaries\Win64\$game")

# Wait for game to load
Write-Host "Waiting for game to start..."
Start-Sleep -Seconds 5

# Launch CE with table
Start-Process "C:\Program Files\Cheat Engine 7.6\cheatengine-x86_64.exe" -ArgumentList "`"$table`""

Write-Host "Game and CE launched!" -ForegroundColor Green
```

### Workflow 2: Data-Driven Table Generation

```powershell
# Generate CE reference table from extracted JSON

$jsonFiles = @(
    "GOP_Item.json",
    "GOP_Monster.json",
    "GOP_Magic.json"
)

$basePath = "D:\Dev\GitHub\GameDumps\games\dragon-quest-3-hd2d\analysis\asset-catalogs\cheat-engine"

foreach ($jsonFile in $jsonFiles) {
    $data = Get-Content (Join-Path $basePath $jsonFile) | ConvertFrom-Json

    Write-Host "`nProcessing $jsonFile..." -ForegroundColor Cyan
    Write-Host "  Total entries: $($data.PSObject.Properties.Count)"

    # Could generate reference tables, documentation, etc.
    # Actual memory addresses would need to be found in CE
}
```

---

## Limitations

### Current Limitations:

1. **CE has minimal native CLI support** - Primary interface is GUI
2. **LuaClient requires CE to be running** - Can't control CE startup
3. **Memory addresses change** - Need pointer scanning in CE first
4. **Process attachment** - Still mostly manual in CE GUI
5. **Anti-cheat detection** - PowerShell + CE may trigger protections

### Workarounds:

- Use CE's **Lua scripting** as primary automation
- Generate **CT files** from PowerShell for CE to load
- Use PowerShell for **data processing** (JSON → reference tables)
- Combine **PowerShell + Lua** for complete workflows

---

## Resources

### Tools

- **Cheat Engine:** https://www.cheatengine.org
- **CEAutoAttach:** https://github.com/mrexodia/CEAutoAttach
- **PowerShell Docs:** https://docs.microsoft.com/powershell

### CE Automation

- **CE Lua API:** https://wiki.cheatengine.org/index.php?title=Lua
- **LuaClient Reference:** https://wiki.cheatengine.org/index.php?title=OpenLuaServer
- **CE Extensions:** https://forum.cheatengine.org/viewforum.php?f=130

### GameDumps Project

- **CE Getting Started:** cheat-engine/tutorials/getting-started.md
- **Lua Scripting Guide:** cheat-engine/tutorials/lua-scripting.md
- **Auto Assembler:** cheat-engine/tutorials/auto-assembler.md

---

## Conclusion

While Cheat Engine's automation capabilities are limited compared to pure command-line tools, PowerShell can:

✅ **Launch CE with specific tables**
✅ **Generate CT files from game data**
✅ **Process extracted JSON for reference**
✅ **Create Lua scripts for CE to execute**
✅ **Communicate via LuaClient pipe API**

**Best approach:** Combine PowerShell data processing + CE Lua automation for powerful workflows.

---

*Last Updated: 2025-11-10*
*CE Version: 7.6*
*PowerShell Version: 7.5+*
