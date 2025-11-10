# GameDumps Project - Claude Context

This document provides full context for the GameDumps project to assist Claude in helping with game asset extraction and analysis.

## Project Overview

**Purpose:** Extract, organize, and analyze game assets from various video games for research, modding, and educational purposes.

**Organization:** Game-centric approach where each game has its own folder with standardized structure.

**Location:** `D:\Dev\GitHub\GameDumps`

**GitHub Repository:** https://github.com/gwol-1/GameDumps

---

## Project Structure

```
GameDumps/
├── README.md                    # Main index with games table
├── .claude/
│   └── claude.md                # This file - project context
├── tools/                       # Shared extraction tools by engine
│   ├── unreal-engine-4/
│   │   ├── FModel/              # Primary UE4 extraction tool
│   │   └── EXTRACTION-GUIDE.md  # Comprehensive UE4 extraction guide
│   ├── unreal-engine-5/
│   └── unity/
└── games/                       # Individual game dumps
    └── dragon-quest-3-hd2d/
        ├── README.md            # Game-specific info and notes
        ├── extracted/           # Raw extracted files
        ├── assets/              # Processed assets (textures, models, audio)
        ├── scripts/             # Extraction/processing scripts
        └── analysis/            # Documentation and findings
```

---

## Current Games

### Dragon Quest III HD-2D Remake

- **Engine:** Unreal Engine 4
- **Platform:** Steam/PC
- **Status:** Initial setup, ready for extraction
- **Path:** `games/dragon-quest-3-hd2d/`
- **PAK Location:** `<Steam>\steamapps\common\Dragon Quest III HD-2D Remake\Game\Content\Paks`
- **Challenges:** PAK files are likely AES encrypted, requires decryption key

**Next Steps:**
1. Download FModel (v4.4.4.0) from https://github.com/4sval/FModel/releases/latest
2. Install to `tools/unreal-engine-4/FModel/`
3. Locate game installation directory
4. Find AES decryption key (check modding communities)
5. Extract assets using FModel
6. Organize extracted assets in game folder structure

---

## Tools Reference

### FModel (Unreal Engine 4/5)

**Description:** GUI-based asset extraction tool for Unreal Engine games

**Installation:**
- Download: https://github.com/4sval/FModel/releases/latest
- Version: 4.4.4.0 (latest as of Oct 2024)
- Install to: `tools/unreal-engine-4/FModel/`
- Extract ZIP contents to folder

**Key Features:**
- Browse PAK file contents
- Preview textures, models, blueprints
- Export to standard formats (PNG, FBX, WAV)
- AES decryption support
- JSON property dumps

**Usage Guide:** See `tools/unreal-engine-4/EXTRACTION-GUIDE.md`

**Configuration:**
- Settings > Output Directory: Set to game's extraction folder
- Settings > AES Keys: Add decryption keys as needed
- Settings > Export Formats: PNG for textures, FBX for models

---

## Extraction Workflows

### Standard UE4 Game Extraction Process

1. **Setup**
   - Ensure FModel is installed
   - Locate game PAK files
   - Check if encryption is used

2. **Decryption (if needed)**
   - Find AES key from community or extract from game executable
   - Add key to FModel (Settings > AES Keys)

3. **Browse Assets**
   - Load PAK files in FModel
   - Explore folder structure
   - Preview assets of interest

4. **Export**
   - Select assets or folders
   - Right-click > Save Texture/Model/Audio
   - Bulk export entire folders if needed

5. **Organize**
   - Copy to game's `extracted/` folder (raw)
   - Process and convert to `assets/` folder
   - Document findings in `analysis/`
   - Save extraction scripts to `scripts/`

6. **Document**
   - Update game README with extraction notes
   - Note tools used, issues encountered, AES keys
   - Create asset catalogs or inventories
   - Update main project README

---

## Common Asset Types

### Textures
- **Formats:** .uasset (Texture2D)
- **Export to:** PNG (recommended), TGA, DDS
- **Locations:** `Game/Content/Textures/`, `*/UI/`, `*/Materials/`
- **Uses:** Character textures, UI elements, environment maps

### 3D Models
- **Formats:** .uasset (SkeletalMesh, StaticMesh)
- **Export to:** FBX (recommended), OBJ, PSK
- **Locations:** `Game/Content/Characters/`, `*/Environment/`, `*/Props/`
- **Uses:** Characters, weapons, environment objects

### Audio
- **Formats:** .uasset (SoundWave)
- **Export to:** WAV (recommended), OGG
- **Locations:** `Game/Content/Audio/`, `*/Sounds/`, `*/Music/`
- **Uses:** Music, SFX, voice lines

### Data/Blueprints
- **Formats:** .uasset (Blueprint, DataTable)
- **Export to:** JSON (property dumps)
- **Locations:** `Game/Content/Blueprints/`, `*/Data/`
- **Uses:** Game logic, item stats, character data

---

## Handling Encrypted PAK Files

### Identifying Encryption
- FModel shows "AES Key Required" message
- Empty file list or cannot read PAK contents
- Modern AAA games often use AES-256 encryption

### Finding AES Keys

**Community Sources:**
- Nexus Mods (game-specific pages, mod descriptions)
- GBAtemp forums (ROM hacking/modding sections)
- Reddit: r/moddingguides, game-specific subreddits
- Discord: Modding community servers
- GitHub: Search for "[game name] AES key"

**Extraction Tools:**
- Cheat Engine (memory scanning)
- x64dbg (debugging)
- Custom AES key finder scripts

**Key Format:**
- 64 hexadecimal characters (32 bytes)
- With or without `0x` prefix
- Example: `0x1234...CDEF` (64 chars)

**Adding to FModel:**
1. Settings > AES Keys
2. Add Key > Enter hex string
3. Reload PAK files

---

## Git Workflow

### Repository Info
- **Remote:** https://github.com/gwol-1/GameDumps
- **User:** gwol-1
- **Email:** wolgamaleldin@gmail.com

### Making Updates

When adding new games or updating documentation:

```bash
# Navigate to project
cd D:\Dev\GitHub\GameDumps

# Check status
git status

# Add changes
git add .

# Commit with descriptive message
git commit -m "Description of changes"

# Push to GitHub
git push
```

### What to Commit
- README files and documentation
- Extraction scripts
- Analysis notes and findings
- Directory structure changes

### What NOT to Commit
- Large extracted assets (textures, models, audio)
- Game executables or copyrighted game files
- AES keys (if legally questionable)
- Personal game installation paths

**Note:** Consider adding a `.gitignore` file to exclude large asset files automatically.

---

## Adding New Games

### Process

1. **Create game folder:**
   ```bash
   mkdir -p games/[game-name-slug]/extracted
   mkdir -p games/[game-name-slug]/assets
   mkdir -p games/[game-name-slug]/scripts
   mkdir -p games/[game-name-slug]/analysis
   ```

2. **Create game README:**
   - Copy template from `games/dragon-quest-3-hd2d/README.md`
   - Update game information
   - Document engine, version, platform
   - Add extraction checklist

3. **Update main README:**
   - Add row to games index table
   - Update engine tools section if new engine
   - Add any special notes

4. **Set up tools:**
   - If new engine, create `tools/[engine-name]/` directory
   - Download/document required tools
   - Create engine-specific guide if needed

5. **Document everything:**
   - Extraction process
   - Tools used
   - Issues encountered
   - Workarounds or solutions

### Naming Convention

Use lowercase with hyphens for folder names:
- `dragon-quest-3-hd2d` ✓
- `final-fantasy-7-remake` ✓
- `Dragon_Quest_III` ✗
- `DQIII` ✗

---

## Troubleshooting Common Issues

### FModel: "AES Key Required"
**Solution:** Find and add the game's AES decryption key (see "Handling Encrypted PAK Files")

### FModel: Crashes on PAK load
**Solutions:**
- Update FModel to latest version
- Verify game files (Steam: Properties > Local Files > Verify)
- Try loading PAK files individually
- Check system memory (close other apps)

### Exported models missing textures
**Solutions:**
- Export textures separately from same asset folder
- Use FBX format which includes material paths
- Manually reassign in 3D software (Blender)

### Cannot find specific asset
**Solutions:**
- Use FModel search (Ctrl+Shift+F)
- Check all PAK files (base game + DLC + patches)
- Asset may have non-obvious name, browse by type instead

---

## Legal and Ethical Guidelines

### Allowed
- Extract assets from games you legally own
- Personal research and analysis
- Creating mods for personal use
- Educational purposes
- Backing up your own game data

### Not Allowed
- Redistributing copyrighted game assets
- Selling extracted assets
- Circumventing DRM for piracy
- Violating game's EULA/ToS
- Commercial use without permission

### Best Practices
- Keep extractions private or within modding communities
- Respect intellectual property
- Give credit to original creators
- Follow community guidelines
- Don't share AES keys publicly if legally questionable

---

## Resources

### Documentation
- **UE4 Extraction Guide:** `tools/unreal-engine-4/EXTRACTION-GUIDE.md`
- **FModel Wiki:** https://github.com/4sval/FModel/wiki
- **TCRF UE4 Guide:** https://tcrf.net/Help:Contents/Finding_Content/Game_Engines/Unreal_Engine_4

### Tools
- **FModel:** https://github.com/4sval/FModel
- **UE Viewer:** https://www.gildor.org/en/projects/umodel
- **QuickBMS:** https://aluigi.altervista.org/quickbms.htm
- **Blender:** https://www.blender.org (for viewing models)

### Communities
- The Cutting Room Floor (TCRF)
- Nexus Mods (game-specific)
- GBAtemp forums
- Reddit: r/gamemodding, r/moddingguides
- Discord: Game-specific modding servers

---

## How Claude Can Help

When assisting with this project, Claude can:

1. **Guide extraction processes**
   - Reference `tools/unreal-engine-4/EXTRACTION-GUIDE.md`
   - Provide step-by-step instructions
   - Troubleshoot FModel issues

2. **Organize extracted assets**
   - Help create folder structures
   - Write organization scripts
   - Generate asset inventories

3. **Create documentation**
   - Update game READMEs with findings
   - Document extraction methods
   - Create asset catalogs

4. **Write automation scripts**
   - Batch processing scripts
   - Asset conversion tools
   - File organization utilities

5. **Search for information**
   - Find AES keys in community sources
   - Locate game file paths
   - Research extraction tools

6. **Maintain the repository**
   - Update documentation
   - Create git commits
   - Manage project structure

---

## Quick Reference

### Key Paths
- **Project Root:** `D:\Dev\GitHub\GameDumps`
- **UE4 Guide:** `tools/unreal-engine-4/EXTRACTION-GUIDE.md`
- **FModel:** `tools/unreal-engine-4/FModel/`
- **Current Game:** `games/dragon-quest-3-hd2d/`

### Key Commands
```bash
# Navigate to project
cd D:\Dev\GitHub\GameDumps

# Check git status
git status

# Commit changes
git add . && git commit -m "Message"

# Push to GitHub
git push

# Create new game structure
mkdir -p games/[game-slug]/{extracted,assets,scripts,analysis}
```

### Next Immediate Steps
1. Download FModel from https://github.com/4sval/FModel/releases/latest
2. Extract to `tools/unreal-engine-4/FModel/`
3. Find Dragon Quest III HD-2D Remake AES key
4. Begin extraction following guide at `tools/unreal-engine-4/EXTRACTION-GUIDE.md`

---

## Project Goals

### Short-term
- Extract Dragon Quest III HD-2D Remake assets
- Document extraction process thoroughly
- Create asset catalog for DQ3

### Medium-term
- Add more UE4 games
- Build library of extraction scripts
- Share findings with modding community

### Long-term
- Support multiple game engines (Unity, RE Engine, etc.)
- Comprehensive tool collection
- Detailed asset analysis for each game
- Contribute to game preservation efforts

---

*Last Updated: 2025-11-10*
*Maintainer: gwol-1*
*Claude: Use this document as authoritative context for the GameDumps project*
