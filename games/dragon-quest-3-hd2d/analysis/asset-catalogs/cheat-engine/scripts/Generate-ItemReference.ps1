# Generate-ItemReference.ps1
# Create item reference from GOP_Item.json for CE usage

<#
.SYNOPSIS
    Generates a human-readable item reference from extracted DQ3 data.

.DESCRIPTION
    This script parses GOP_Item.json and creates reference materials
    useful for Cheat Engine research, including:
    - Item ID lists
    - Price tables
    - Equipment stats
    - Reference CT files (placeholders for addresses)

.PARAMETER OutputFormat
    Format for output: "Text", "CSV", "Markdown", or "All"
    Default: "All"

.EXAMPLE
    .\Generate-ItemReference.ps1
    Generates all reference formats

.EXAMPLE
    .\Generate-ItemReference.ps1 -OutputFormat "Markdown"
    Generates only markdown reference
#>

param(
    [Parameter(Mandatory=$false)]
    [ValidateSet("Text", "CSV", "Markdown", "All")]
    [string]$OutputFormat = "All"
)

# Paths
$jsonPath = "D:\Dev\GitHub\GameDumps\games\dragon-quest-3-hd2d\analysis\asset-catalogs\cheat-engine\GOP_Item.json"
$outputDir = "D:\Dev\GitHub\GameDumps\games\dragon-quest-3-hd2d\analysis\asset-catalogs\cheat-engine\reference"

# Create output directory
if (-not (Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
}

Write-Host "=== DQ3 Item Reference Generator ===" -ForegroundColor Yellow
Write-Host ""

# Check if JSON exists
if (-not (Test-Path $jsonPath)) {
    Write-Error "GOP_Item.json not found at: $jsonPath"
    Write-Host "Please ensure game data has been extracted"
    exit 1
}

# Load item data
Write-Host "[1/4] Loading item data..." -ForegroundColor Cyan
$itemData = Get-Content $jsonPath -Raw | ConvertFrom-Json
$items = $itemData.PSObject.Properties | ForEach-Object { $_.Value }
Write-Host "  Loaded $($items.Count) items" -ForegroundColor Green

# Categorize items
Write-Host "`n[2/4] Categorizing items..." -ForegroundColor Cyan
$weapons = $items | Where-Object { $_.SelfId -like "*WEAPON*" }
$armor = $items | Where-Object { $_.SelfId -like "*ARMOR*" -or $_.SelfId -like "*SHIELD*" }
$consumables = $items | Where-Object { $_.SelfId -like "*ITEM_*" -and $_.SelfId -notlike "*EQUIP*" }
$valuable = $items | Where-Object { $_.BuyPrice -ge 10000 }

Write-Host "  Weapons: $($weapons.Count)" -ForegroundColor White
Write-Host "  Armor/Shields: $($armor.Count)" -ForegroundColor White
Write-Host "  Consumables: $($consumables.Count)" -ForegroundColor White
Write-Host "  High-value items (10000G+): $($valuable.Count)" -ForegroundColor White

# Function: Generate Markdown
function Export-MarkdownReference {
    Write-Host "`n[3/4] Generating Markdown reference..." -ForegroundColor Cyan

    $md = @"
# Dragon Quest III HD-2D - Item Reference

**Generated:** $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')
**Source:** GOP_Item.json
**Total Items:** $($items.Count)

---

## 💰 High-Value Items (10000G+)

Useful for selling or identifying valuable drops.

| Item Name | Buy Price | Sell Price | Type |
|-----------|-----------|------------|------|
"@

    foreach ($item in ($valuable | Sort-Object -Property BuyPrice -Descending | Select-Object -First 20)) {
        $name = $item.SelfId -replace 'ITEM_EQUIP_WEAPON_|ITEM_EQUIP_ARMOR_|ITEM_', ''
        $buyPrice = if ($item.BuyPrice) { "$($item.BuyPrice)G" } else { "N/A" }
        $sellPrice = if ($item.SellPrice) { "$($item.SellPrice)G" } else { "N/A" }
        $type = if ($item.WeaponType) { "Weapon" } elseif ($item.SelfId -like "*ARMOR*") { "Armor" } else { "Item" }

        $md += "`n| $name | $buyPrice | $sellPrice | $type |"
    }

    $md += @"


---

## ⚔️ Weapons by Attack Power

Top 20 weapons sorted by ParamValue (attack power).

| Weapon Name | Attack | Buy Price | Weapon Type |
|-------------|--------|-----------|-------------|
"@

    foreach ($weapon in ($weapons | Where-Object { $_.ParamValue } | Sort-Object -Property ParamValue -Descending | Select-Object -First 20)) {
        $name = $weapon.SelfId -replace 'ITEM_EQUIP_WEAPON_', ''
        $attack = $weapon.ParamValue
        $price = if ($weapon.BuyPrice) { "$($weapon.BuyPrice)G" } else { "N/A" }
        $type = $weapon.WeaponType -replace 'EWeaponType::', ''

        $md += "`n| $name | $attack | $price | $type |"
    }

    $md += @"


---

## 🛡️ Armor by Defense

Top 20 armor pieces sorted by ParamValue (defense).

| Armor Name | Defense | Buy Price |
|------------|---------|-----------|
"@

    foreach ($armorPiece in ($armor | Where-Object { $_.ParamValue } | Sort-Object -Property ParamValue -Descending | Select-Object -First 20)) {
        $name = $armorPiece.SelfId -replace 'ITEM_EQUIP_ARMOR_|ITEM_EQUIP_SHIELD_', ''
        $defense = $armorPiece.ParamValue
        $price = if ($armorPiece.BuyPrice) { "$($armorPiece.BuyPrice)G" } else { "N/A" }

        $md += "`n| $name | $defense | $price |"
    }

    $md += @"


---

## 📦 All Items (Full List)

Complete item database for reference.

| Item ID | Name | Buy | Sell | Param | Type |
|---------|------|-----|------|-------|------|
"@

    foreach ($item in ($items | Sort-Object -Property SelfId)) {
        $id = $item.SelfId
        $name = $id -replace 'ITEM_EQUIP_WEAPON_|ITEM_EQUIP_ARMOR_|ITEM_EQUIP_SHIELD_|ITEM_', ''
        $buy = if ($item.BuyPrice) { $item.BuyPrice } else { "-" }
        $sell = if ($item.SellPrice) { $item.SellPrice } else { "-" }
        $param = if ($item.ParamValue) { $item.ParamValue } else { "-" }
        $type = if ($item.WeaponType) { $item.WeaponType -replace 'EWeaponType::', '' } else { "Item" }

        # Truncate long IDs for readability
        if ($name.Length -gt 30) {
            $name = $name.Substring(0, 27) + "..."
        }

        $md += "`n| ``$id`` | $name | $buy | $sell | $param | $type |"
    }

    $md += @"


---

## 🎮 Usage with Cheat Engine

### Finding Item IDs in Memory

1. Open CE and attach to DQIIIHD2DRemake.exe
2. Search for item quantities or IDs
3. Use this reference to identify which item you've found
4. Modify item ID to spawn different items

### Example: Spawning Items

If you find an item slot in memory:
- Address contains item ID (likely matches SelfId or a derivative)
- Change ID to spawn different items
- Reference BuyPrice/SellPrice for valuable items

### Tips

- High-value items are great for quick gold
- ParamValue shows weapon attack / armor defense
- Some items may be quest-specific (modify carefully)

---

*Generated from extracted game data - Use responsibly!*
"@

    $mdPath = Join-Path $outputDir "item-reference.md"
    $md | Out-File -FilePath $mdPath -Encoding UTF8
    Write-Host "  Created: item-reference.md" -ForegroundColor Green
}

# Function: Generate CSV
function Export-CSVReference {
    Write-Host "`n[3/4] Generating CSV reference..." -ForegroundColor Cyan

    $csvData = $items | Select-Object -Property SelfId, BuyPrice, SellPrice, ParamValue, WeaponType
    $csvPath = Join-Path $outputDir "items.csv"
    $csvData | Export-Csv -Path $csvPath -NoTypeInformation -Encoding UTF8

    Write-Host "  Created: items.csv ($($items.Count) rows)" -ForegroundColor Green
}

# Function: Generate text reference
function Export-TextReference {
    Write-Host "`n[3/4] Generating text reference..." -ForegroundColor Cyan

    $text = @"
DRAGON QUEST III HD-2D REMAKE - ITEM REFERENCE
Generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')
Source: GOP_Item.json
Total Items: $($items.Count)

===============================================================================
HIGH-VALUE ITEMS (Top 20)
===============================================================================

"@

    foreach ($item in ($valuable | Sort-Object -Property BuyPrice -Descending | Select-Object -First 20)) {
        $name = $item.SelfId -replace 'ITEM_EQUIP_WEAPON_|ITEM_EQUIP_ARMOR_|ITEM_', ''
        $text += "$name`n"
        $text += "  Buy: $($item.BuyPrice)G | Sell: $($item.SellPrice)G`n`n"
    }

    $text += @"

===============================================================================
WEAPONS BY ATTACK (Top 20)
===============================================================================

"@

    foreach ($weapon in ($weapons | Where-Object { $_.ParamValue } | Sort-Object -Property ParamValue -Descending | Select-Object -First 20)) {
        $name = $weapon.SelfId -replace 'ITEM_EQUIP_WEAPON_', ''
        $text += "$name - ATK: $($weapon.ParamValue) - Price: $($weapon.BuyPrice)G`n"
    }

    $txtPath = Join-Path $outputDir "item-reference.txt"
    $text | Out-File -FilePath $txtPath -Encoding UTF8
    Write-Host "  Created: item-reference.txt" -ForegroundColor Green
}

# Execute based on format
if ($OutputFormat -eq "All" -or $OutputFormat -eq "Markdown") {
    Export-MarkdownReference
}

if ($OutputFormat -eq "All" -or $OutputFormat -eq "CSV") {
    Export-CSVReference
}

if ($OutputFormat -eq "All" -or $OutputFormat -eq "Text") {
    Export-TextReference
}

# Summary
Write-Host "`n[4/4] Summary" -ForegroundColor Cyan
Write-Host "  Output directory: $outputDir" -ForegroundColor White
Write-Host "  Files generated:" -ForegroundColor White

Get-ChildItem -Path $outputDir | ForEach-Object {
    $size = if ($_.Length -gt 1KB) {
        "{0:N0} KB" -f ($_.Length / 1KB)
    } else {
        "$($_.Length) bytes"
    }
    Write-Host "    - $($_.Name) ($size)" -ForegroundColor Gray
}

Write-Host "`n=== Done! ===" -ForegroundColor Green
Write-Host "These files can be used as reference while working with CE."
