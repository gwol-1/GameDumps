# Game Dumps Collection

This repository contains game dumps, extracted assets, and analysis for various games organized by game title.

## Getting Started

### For Dragon Quest III HD-2D Remake

1. **Download FModel:** Get the latest version from [FModel Releases](https://github.com/4sval/FModel/releases/latest)
2. **Install:** Extract to `tools/unreal-engine-4/FModel/`
3. **Read the Guide:** Follow the comprehensive extraction guide at [`tools/unreal-engine-4/EXTRACTION-GUIDE.md`](tools/unreal-engine-4/EXTRACTION-GUIDE.md)
4. **Locate Game Files:** Find your Steam installation's PAK files
5. **Extract Assets:** Use FModel to browse and export game assets

**Note:** Dragon Quest III HD-2D may use encrypted PAK files. You'll need an AES decryption key - check the extraction guide for details.

## Directory Structure

- `tools/` - Shared tools and utilities organized by game engine
- `games/` - Individual game dumps and analysis
- `cheat-engine/` - Cheat Engine resources and multi-game setup
- `.claude/` - Claude AI context and project documentation

## Games Index

| Game | Engine | Version | Status | Path |
|------|--------|---------|--------|------|
| Dragon Quest III HD-2D Remake | Unreal Engine 4 | 1.2.1 | ✅ Complete Extraction | `games/dragon-quest-3-hd2d/` |

## Tools by Engine

### Unreal Engine 4
- **Location:** `tools/unreal-engine-4/`
- **Primary Tool:** FModel - Asset extraction and browsing
- **Extraction Guide:** [`tools/unreal-engine-4/EXTRACTION-GUIDE.md`](tools/unreal-engine-4/EXTRACTION-GUIDE.md)
- **Games using this engine:** Dragon Quest III HD-2D Remake

### Unreal Engine 5
- Location: `tools/unreal-engine-5/`
- Games using this engine: (none yet)

### Unity
- Location: `tools/unity/`
- Games using this engine: (none yet)

## Cheat Engine Integration

This project supports **multi-game Cheat Engine workflows** for memory editing and game modification.

### Quick Start with CE

1. **Download Cheat Engine 7.6:** [Official Site](https://www.cheatengine.org/downloads.php)
2. **Install:** Extract to `tools/cheat-engine/`
3. **Read the Guide:** See [`cheat-engine/README.md`](cheat-engine/README.md) for complete setup

### Resources

- **Multi-Game CE Guide:** [`cheat-engine/README.md`](cheat-engine/README.md)
- **Latest Version:** Cheat Engine 7.6 (Feb 2025)
- **Table Database:** [FearlessRevolution](https://fearlessrevolution.com) (14,909+ tables)
- **Tutorials:** [CE Forums](https://forum.cheatengine.org/viewforum.php?f=7)

### Structure

```
cheat-engine/
├── shared-tables/     # Reusable CE table templates
├── tutorials/         # Learning resources
└── scripts/           # Lua scripts for automation

games/[game-name]/analysis/asset-catalogs/cheat-engine/
├── [game]_data.json  # Extracted game data
├── [game]-tables/    # Game-specific CE tables
└── README.md         # Game-specific CE guide
```

**See Dragon Quest III example:** `games/dragon-quest-3-hd2d/analysis/asset-catalogs/cheat-engine/`

## Adding New Games

1. Create a new folder in `games/` with a descriptive name (use lowercase with hyphens)
2. Use the standard subdirectory structure:
   - `extracted/` - Raw extracted files from the game
   - `assets/` - Processed or converted assets
   - `scripts/` - Scripts used for extraction/analysis
   - `analysis/` - Documentation and findings
3. Create a `README.md` in the game folder with engine info and notes
4. Update this index with the new game

## Notes

- Keep engine-specific tools in the `tools/` directory for reuse across games
- Each game folder should be self-contained for easy sharing/archiving
- Document extraction methods and tools used in each game's README
