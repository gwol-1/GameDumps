# Cheat Engine - Multi-Game Setup

This folder contains shared Cheat Engine resources, tools, and documentation for working with multiple games.

## 📥 Latest Cheat Engine Version

### Cheat Engine 7.6 (Latest - February 12, 2025)

**Official Download:** https://www.cheatengine.org/downloads.php

**What's New in 7.6:**
- Better error reporting
- Improved symbol synchronization
- Enhanced stability

**Installation Notes:**
- ⚠️ Some antivirus software may flag CE as malware (false positive)
- Disable AV temporarily if installation issues occur
- CE is for educational and single-player use only

**Download CE 7.6:**
```
1. Visit: https://www.cheatengine.org/downloads.php
2. Download Cheat Engine 7.6 installer
3. Extract to: tools/cheat-engine/
4. Run CheatEngine.exe
```

---

## 🌐 Essential Online Resources

### Official Resources

| Resource | URL | Description |
|----------|-----|-------------|
| **Official Website** | https://cheatengine.org | Main site, downloads |
| **Official Forums** | https://forum.cheatengine.org | Community support |
| **CE Tutorials Section** | https://forum.cheatengine.org/viewforum.php?f=7 | Step-by-step guides |
| **CE Wiki** | https://wiki.cheatengine.org | Documentation |
| **GitHub Repository** | https://github.com/cheat-engine/cheat-engine | Source code |

### Community Resources

| Resource | URL | Description |
|----------|-----|-------------|
| **FearlessRevolution** | https://fearlessrevolution.com | **Best table database** (14,909+ tables!) |
| **GuidedHacking** | https://guidedhacking.com | Advanced tutorials, courses |
| **Open Cheat Tables** | https://opencheattables.com | Table sharing, guides |

### FearlessRevolution (Primary Table Database)

**Why FearlessRevolution?**
- 14,909+ cheat tables across 299 pages
- Active community (updated November 2025)
- Tables for latest games
- Tutorials and scripting help
- Trainer downloads

**Key Sections:**
- **Tables:** https://fearlessrevolution.com/viewforum.php?f=4
- **Requests:** Request tables for games
- **Tutorials:** Game hacking guides
- **Tools & Trainers:** Pre-made tools

---

## 📂 Project Structure

### Multi-Game CE Organization

```
GameDumps/
├── cheat-engine/                    # Shared CE resources (this folder)
│   ├── README.md                    # This file
│   ├── shared-tables/               # Tables usable across games
│   │   ├── common-pointers.CT      # Generic pointer templates
│   │   ├── health-templates.CT      # Health modification templates
│   │   └── currency-templates.CT    # Gold/money templates
│   ├── tutorials/                   # CE learning resources
│   │   ├── getting-started.md      # CE basics
│   │   ├── pointer-scanning.md     # Finding pointers
│   │   └── lua-scripting.md        # Advanced scripting
│   └── scripts/                     # Reusable CE scripts
│       ├── auto-attach.lua         # Auto-attach helper
│       └── value-logger.lua        # Log value changes
│
├── tools/
│   └── cheat-engine/                # CE installation
│       └── CheatEngine.exe         # CE 7.6
│
└── games/
    ├── dragon-quest-3-hd2d/
    │   └── analysis/
    │       └── asset-catalogs/
    │           └── cheat-engine/
    │               ├── GOP_Item.json           # Item data
    │               ├── GOP_Monster.json        # Monster data
    │               ├── GOP_Magic.json          # Spell data
    │               ├── dq3-tables/            # DQ3-specific tables
    │               │   ├── dq3-gold.CT        # Gold modifications
    │               │   ├── dq3-items.CT       # Item spawning
    │               │   └── dq3-exp.CT         # Experience mods
    │               └── README.md               # DQ3 CE guide
    │
    └── [future-game]/
        └── analysis/
            └── asset-catalogs/
                └── cheat-engine/
                    ├── [game-data].json
                    ├── [game]-tables/
                    └── README.md
```

---

## 🎮 Per-Game CE Workflow

### 1. Game Dump Phase (What We Did for DQ3)

```bash
games/[game-name]/
└── analysis/
    └── asset-catalogs/
        └── cheat-engine/
            ├── [game]_items.json      # Item data from extraction
            ├── [game]_enemies.json    # Enemy stats
            ├── [game]_spells.json     # Spell data
            └── README.md               # Game-specific CE guide
```

### 2. CE Research Phase

```bash
games/[game-name]/
└── analysis/
    └── asset-catalogs/
        └── cheat-engine/
            ├── [game-data].json       # Extracted data
            ├── [game]-tables/         # CE tables for this game
            │   ├── health.CT          # Health modification
            │   ├── gold.CT            # Currency
            │   ├── items.CT           # Inventory
            │   └── master.CT          # Combined table
            ├── notes.md               # Research notes
            └── README.md              # Usage guide
```

### 3. Shared Resources

```bash
cheat-engine/
├── shared-tables/                 # Templates usable for any game
│   ├── health-template.CT        # Generic health finding
│   ├── pointer-template.CT       # Pointer scan workflow
│   └── currency-template.CT      # Money/gold template
└── scripts/                       # Lua scripts
    └── auto-attach.lua           # Auto-attach to game process
```

---

## 🚀 Quick Start: New Game Setup

### Step 1: Extract Game Data
1. Follow game dump process (FModel, etc.)
2. Export relevant JSON data tables
3. Save to `games/[game]/analysis/asset-catalogs/cheat-engine/`

### Step 2: Create CE Folder Structure
```bash
mkdir -p games/[game-name]/analysis/asset-catalogs/cheat-engine/[game]-tables
```

### Step 3: Create Game-Specific README
Copy template from `games/dragon-quest-3-hd2d/analysis/asset-catalogs/cheat-engine/README.md`

### Step 4: Begin CE Research
1. Open Cheat Engine 7.6
2. Attach to game process
3. Use extracted JSON data as reference
4. Find and document addresses
5. Save tables to `[game]-tables/`

### Step 5: Document Findings
- Update game's CE README
- Note working addresses
- Document pointer paths
- Share findings (optional)

---

## 📚 Learning Resources

### For Beginners

**Start Here:**
1. **CE Official Tutorial** (Built into CE)
   - Open CE > Help > Cheat Engine Tutorial
   - Learn basics of memory scanning
   - Step 1-9 covers fundamentals

2. **Official Forums Basics**
   - https://forum.cheatengine.org/viewtopic.php?t=26540
   - Cheat Engine Basics Tutorial (Steps 1-7)

3. **Our Local Tutorial**
   - `cheat-engine/tutorials/getting-started.md` (to be created)

### Intermediate Topics

- **Pointer Scanning:** Find dynamic addresses
- **Code Injection:** Modify game logic
- **AOB Scanning:** Find code patterns
- **Lua Scripting:** Automate CE tasks

**Resources:**
- CE Wiki Tutorials: https://wiki.cheatengine.org/index.php?title=Tutorials
- GuidedHacking Course: https://guidedhacking.com

### Advanced Topics

- **Assembly Language:** Understand game code
- **Reverse Engineering:** Analyze game structures
- **Custom Scripts:** Complex modifications

---

## 🎯 Best Practices

### Organization

✅ **Do:**
- Keep game-specific tables in game folders
- Use shared templates for common patterns
- Document pointer paths and offsets
- Backup working tables regularly
- Version control table files (.CT)

❌ **Don't:**
- Mix tables from different games
- Lose track of game versions (patches break tables)
- Forget to document how you found addresses

### Safety

⚠️ **Important:**
- **Backup saves** before using CE
- **Test on separate saves** first
- **Single-player only** - never use online
- **Respect EULAs** - understand game ToS
- **No piracy** - only use on owned games

### Efficiency

**Use Extracted Game Data:**
1. Open `GOP_Item.json` to find item IDs
2. Search for those IDs in game memory
3. Modify values based on data table info
4. Much faster than blind scanning!

**Example Workflow:**
```
1. Extracted data shows: "Copper Sword" = ID 100, Attack = 10
2. Search CE for value 100 or 10
3. Modify item ID to spawn different items
4. Or modify attack value to 999
```

---

## 🔗 Useful Links by Category

### Table Databases
- [FearlessRevolution Tables](https://fearlessrevolution.com/viewforum.php?f=4) - 14,909+ tables
- [Open Cheat Tables](https://opencheattables.com) - Alternative DB
- [CE Forum Tables](https://forum.cheatengine.org/viewforum.php?f=28) - Official forum tables

### Learning
- [CE Wiki Tutorials](https://wiki.cheatengine.org/index.php?title=Tutorials)
- [GuidedHacking](https://guidedhacking.com) - Premium courses
- [CE Tutorial (Built-in)](https://www.cheatengine.org/gettingstarted.php)

### Community
- [CE Official Forums](https://forum.cheatengine.org)
- [FearlessRevolution Forums](https://fearlessrevolution.com)
- [r/cheatengine](https://reddit.com/r/cheatengine)

### Tools
- [CE Downloads](https://www.cheatengine.org/downloads.php)
- [CE GitHub](https://github.com/cheat-engine/cheat-engine)
- [CE Source](https://github.com/cheat-engine/cheat-engine/releases)

---

## 📝 Template: New Game CE README

When adding a new game, copy this template:

```markdown
# [Game Name] - Cheat Engine Guide

## Game Information
- **Engine:** [Engine Type]
- **Version:** [Game Version]
- **Process Name:** [GameName.exe]

## Extracted Data Files
- `[game]_items.json` - Item IDs and stats
- `[game]_enemies.json` - Enemy data
- `[game]_spells.json` - Spell information

## Cheat Tables
Located in: `[game]-tables/`

- `health.CT` - Health modifications
- `gold.CT` - Currency/money
- `items.CT` - Inventory editing
- `master.CT` - All-in-one table

## Quick Reference
| Item | ID | Value |
|------|----|----- |
| [Item Name] | [ID] | [Stats] |

## Pointer Paths
Document reliable pointers here.

## Notes
Research findings and tips.
```

---

## 🆘 Troubleshooting

### CE Won't Attach to Game
- Run CE as Administrator
- Disable anti-cheat (if any)
- Check game has no protection

### Values Keep Changing
- Use pointer scans
- Find static addresses
- Use code injection

### Table Stopped Working
- Game was patched
- Addresses changed
- Need to re-scan

### Need Help?
1. Check game's CE README first
2. Search FearlessRevolution for game
3. Ask on CE forums
4. Check game-specific communities

---

## 🎮 Supported Games (Current)

| Game | Status | Tables | Data Extracted |
|------|--------|--------|----------------|
| Dragon Quest III HD-2D | ✅ Complete | In Progress | ✅ Full Dump |
| [Future Game] | ⏳ Pending | - | - |

---

## 🔄 Workflow Summary

```
1. Dump Game → Extract Data Tables (JSON)
                    ↓
2. Analyze Data → Find IDs, Values, Stats
                    ↓
3. Use CE → Search for values in memory
                    ↓
4. Create Tables → Save working addresses
                    ↓
5. Document → Update README, share findings
                    ↓
6. Enjoy! → Use responsibly
```

---

*Last Updated: 2025-11-10*
*CE Version: 7.6*
*Maintainer: gwol-1*
