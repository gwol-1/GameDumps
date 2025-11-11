# New-CETable.ps1
# Generate Cheat Engine .CT files programmatically

<#
.SYNOPSIS
    Creates a Cheat Engine cheat table (.CT file) from address data.

.DESCRIPTION
    This script generates a .CT file with specified memory addresses and descriptions.
    Useful for creating reference tables or automating table generation.

.PARAMETER OutputPath
    Path where the .CT file will be saved

.PARAMETER CheatRecords
    Array of hashtables containing cheat data. Each record should have:
    - Description: Display name for the address
    - Address: Memory address (can be hex like "0x12345678" or symbolic like "game.exe+123456")
    - Type: Value type ("4 Bytes", "Float", "Double", "String", etc.)
    - Value: (Optional) Default value

.EXAMPLE
    $records = @(
        @{ Description = "Player Gold"; Address = "0x12345678"; Type = "4 Bytes" }
        @{ Description = "Health"; Address = "game.exe+ABCDEF"; Type = "4 Bytes"; Value = "999" }
    )
    .\New-CETable.ps1 -OutputPath "C:\tables\my-game.CT" -CheatRecords $records
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$OutputPath,

    [Parameter(Mandatory=$true)]
    [array]$CheatRecords,

    [Parameter(Mandatory=$false)]
    [string]$TableName = "Generated Cheat Table",

    [Parameter(Mandatory=$false)]
    [string]$Comment = "Auto-generated from PowerShell"
)

# Validate output path
$outputDir = Split-Path $OutputPath -Parent
if ($outputDir -and -not (Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
}

# Map friendly type names to CE type IDs
$typeMap = @{
    "Byte" = "0"
    "2 Bytes" = "1"
    "4 Bytes" = "2"
    "8 Bytes" = "3"
    "Float" = "4"
    "Double" = "5"
    "String" = "6"
    "Array of Bytes" = "7"
    "Binary" = "8"
    "All" = "9"
}

Write-Host "Generating Cheat Table: $TableName" -ForegroundColor Cyan
Write-Host "  Records: $($CheatRecords.Count)" -ForegroundColor White
Write-Host "  Output: $OutputPath" -ForegroundColor White

# Start XML structure
$xml = @"
<?xml version="1.0" encoding="utf-8"?>
<CheatTable CheatEngineTableVersion="42">
  <CheatEntries>
"@

# Add each cheat record
$id = 0
foreach ($record in $CheatRecords) {
    if (-not $record.Description -or -not $record.Address) {
        Write-Warning "Skipping invalid record (missing Description or Address)"
        continue
    }

    # Get type ID
    $typeId = $typeMap[$record.Type]
    if (-not $typeId) {
        Write-Warning "Unknown type '$($record.Type)' for $($record.Description), defaulting to 4 Bytes"
        $typeId = "2"
    }

    $xml += @"

    <CheatEntry>
      <ID>$id</ID>
      <Description>"$($record.Description)"</Description>
      <VariableType>$typeId</VariableType>
      <Address>$($record.Address)</Address>
"@

    # Add value if provided
    if ($record.Value) {
        $xml += @"

      <ShowAsHex>0</ShowAsHex>
      <VariableValue>$($record.Value)</VariableValue>
"@
    }

    $xml += @"

    </CheatEntry>
"@
    $id++
}

# Close CheatEntries and add metadata
$xml += @"

  </CheatEntries>
  <UserdefinedSymbols/>
  <Comments>
    <Comment>$Comment</Comment>
    <Comment>Created: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')</Comment>
    <Comment>Total entries: $id</Comment>
  </Comments>
</CheatTable>
"@

# Write to file
try {
    $xml | Out-File -FilePath $OutputPath -Encoding UTF8 -Force
    Write-Host "`nCheat table created successfully!" -ForegroundColor Green
    Write-Host "  File: $OutputPath"
    Write-Host "  Size: $((Get-Item $OutputPath).Length) bytes"
    Write-Host "`nYou can now open this file in Cheat Engine."
}
catch {
    Write-Error "Failed to create cheat table: $_"
    exit 1
}
