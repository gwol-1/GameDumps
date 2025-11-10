# Game Dumps Collection

This repository contains game dumps, extracted assets, and analysis for various games organized by game title.

## Directory Structure

- `tools/` - Shared tools and utilities organized by game engine
- `games/` - Individual game dumps and analysis

## Games Index

| Game | Engine | Version | Status | Path |
|------|--------|---------|--------|------|
| Dragon Quest III HD-2D Remake | Unreal Engine 4 | - | Initial Setup | `games/dragon-quest-3-hd2d/` |

## Tools by Engine

### Unreal Engine 4
- Location: `tools/unreal-engine-4/`
- Games using this engine: Dragon Quest III HD-2D Remake

### Unreal Engine 5
- Location: `tools/unreal-engine-5/`
- Games using this engine: (none yet)

### Unity
- Location: `tools/unity/`
- Games using this engine: (none yet)

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
