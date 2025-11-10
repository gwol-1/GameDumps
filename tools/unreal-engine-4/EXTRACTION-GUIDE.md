# Unreal Engine 4 Game Extraction Guide

This guide covers the process of extracting assets from Unreal Engine 4 games, with specific focus on Dragon Quest III HD-2D Remake.

## Table of Contents

1. [Tools Overview](#tools-overview)
2. [FModel Setup](#fmodel-setup)
3. [Extracting Dragon Quest III HD-2D Remake](#extracting-dragon-quest-iii-hd-2d-remake)
4. [Dealing with Encrypted PAK Files](#dealing-with-encrypted-pak-files)
5. [Asset Types and Export Formats](#asset-types-and-export-formats)
6. [Troubleshooting](#troubleshooting)

---

## Tools Overview

### Primary Tool: FModel

**FModel** is the recommended tool for UE4/UE5 asset extraction.

- **GitHub:** https://github.com/4sval/FModel
- **Latest Version:** 4.4.4.0 (as of October 2024)
- **Download:** https://github.com/4sval/FModel/releases/latest
- **Install Location:** `tools/unreal-engine-4/FModel/`

**Features:**
- GUI-based asset browser
- Supports textures, models, audio, blueprints
- Export to standard formats (PNG, OBJ, FBX, PSK, WAV, etc.)
- AES decryption support for encrypted PAK files
- JSON property viewer for assets

### Alternative Tools

1. **UE Viewer (umodel)**
   - Lightweight 3D model/texture viewer
   - Good for quick previews
   - Website: https://www.gildor.org/en/projects/umodel

2. **QuickBMS + Scripts**
   - Script-based extraction
   - Useful for bulk operations

3. **UAssetGUI**
   - Direct .uasset file editing
   - For advanced asset modification

---

## FModel Setup

### Installation Steps

1. **Download FModel**
   - Visit: https://github.com/4sval/FModel/releases/latest
   - Download the Windows ZIP file
   - Extract to: `D:\Dev\GitHub\GameDumps\tools\unreal-engine-4\FModel\`

2. **First Launch**
   - Run `FModel.exe`
   - FModel will create configuration files on first run

3. **Configure Settings**
   - **Settings > General > Output Directory:** Set to your game's extraction folder
   - **Settings > General > UE Version:** Auto-detect or set manually
   - **Settings > Models > Export Format:** Choose FBX, OBJ, or PSK
   - **Settings > Textures > Export Format:** Choose PNG or TGA

### Directory Structure

After setup, your tools directory should look like:
```
tools/unreal-engine-4/
├── FModel/
│   ├── FModel.exe
│   ├── Output/          (exported assets)
│   └── Backups/         (saved PAK mappings)
└── EXTRACTION-GUIDE.md  (this file)
```

---

## Extracting Dragon Quest III HD-2D Remake

### Game Information

- **Engine:** Unreal Engine 4
- **Platform:** Steam/PC
- **PAK Location:** `<Steam>\steamapps\common\Dragon Quest III HD-2D Remake\Game\Content\Paks`
- **Encryption:** Likely AES encrypted (requires key)

### Step-by-Step Process

#### Step 1: Locate Game Files

1. Find your Steam installation directory
2. Navigate to: `steamapps\common\Dragon Quest III HD-2D Remake\Game\Content\Paks`
3. You should see `.pak` files here

**Common Steam locations:**
- `C:\Program Files (x86)\Steam\`
- `D:\Steam\`
- `E:\SteamLibrary\`

#### Step 2: Open in FModel

1. Launch FModel
2. **Settings > Directory Selector:**
   - Navigate to the game's root folder (where the .exe is)
   - Or directly to the `Paks` folder
3. Click "OK"

#### Step 3: Check for Encryption

If you see "AES Key Required" or empty file lists:
- The PAK files are encrypted
- You need an AES decryption key
- See [Dealing with Encrypted PAK Files](#dealing-with-encrypted-pak-files)

#### Step 4: Browse and Extract Assets

1. **Browse the file tree:**
   - Expand folders in the left panel
   - Common locations:
     - `Game/Content/` - Game assets
     - `Game/Content/Characters/` - Character models
     - `Game/Content/Environment/` - Environment assets
     - `Game/Content/UI/` - Interface textures
     - `Game/Content/Audio/` - Sound files

2. **Preview assets:**
   - Click on any file to preview in the right panel
   - FModel shows textures, models, and properties

3. **Export assets:**
   - Right-click on a file or folder
   - Choose "Save Texture (.png)" or "Save Model (.fbx)"
   - Or use "Save Folder's Packages (.json)" for bulk export
   - Files save to the Output directory

#### Step 5: Organize Extracted Assets

Copy extracted assets to your game folder:
```
games/dragon-quest-3-hd2d/
├── extracted/          (raw PAK contents)
├── assets/
│   ├── textures/       (converted PNGs)
│   ├── models/         (FBX/OBJ files)
│   ├── audio/          (WAV files)
│   └── ui/             (UI textures)
├── scripts/            (extraction scripts)
└── analysis/           (documentation)
```

---

## Dealing with Encrypted PAK Files

### Understanding Encryption

Modern UE4 games often encrypt PAK files using AES-256 encryption. Dragon Quest III HD-2D Remake likely uses this protection.

### Finding the AES Key

**Method 1: Community Sources**
- Check modding communities:
  - Nexus Mods (game-specific pages)
  - GBAtemp forums
  - Reddit (r/dragonquest, r/moddingguides)
  - Discord modding servers

**Method 2: Extract from Executable**
The AES key is stored in the game's executable. Tools that can help:

1. **Cheat Engine** (memory scanning)
2. **x64dbg** (debugging/memory inspection)
3. **AES Key Finder scripts** (various GitHub projects)

**Key Format:**
- 64 hexadecimal characters (32 bytes)
- Example: `0x1234567890ABCDEF1234567890ABCDEF1234567890ABCDEF1234567890ABCDEF`

### Adding Key to FModel

1. Open FModel
2. **Settings > AES Keys**
3. Click "Add Key"
4. **Dynamic Key:** Enter the 64-character hex key (with or without 0x prefix)
5. Click "OK" and reload the PAK files

### Legal and Ethical Considerations

- Only extract assets from games you own
- Respect copyright and intellectual property
- Don't redistribute copyrighted assets
- Use for personal research, modding, or educational purposes
- Follow the game's EULA and Terms of Service

---

## Asset Types and Export Formats

### Textures

**Unreal Format:** `.uasset` (Texture2D)

**Export Options:**
- **PNG:** Lossless, widely supported (recommended)
- **TGA:** Uncompressed, preserves alpha channel
- **DDS:** DirectX texture format

**Common Uses:**
- Character skins/outfits
- Environment textures
- UI elements

### 3D Models

**Unreal Formats:** `.uasset` (SkeletalMesh, StaticMesh)

**Export Options:**
- **FBX:** Industry standard, includes animations, materials
- **OBJ:** Simple format, no animations
- **PSK/PSA:** Unreal-specific formats (for re-import)
- **glTF:** Modern web-friendly format

**Common Uses:**
- Character models
- Weapons and items
- Environment props

### Audio

**Unreal Formats:** `.uasset` (SoundWave)

**Export Options:**
- **WAV:** Uncompressed audio (recommended)
- **OGG:** Compressed, smaller file size

**Common Uses:**
- Music tracks
- Sound effects
- Voice lines

### Blueprints and Data

**Unreal Formats:** `.uasset` (Blueprint, DataTable)

**Export Options:**
- **JSON:** Property dump (readable data)

**Common Uses:**
- Game logic analysis
- Item/character stats
- Quest data

---

## Troubleshooting

### Issue: "AES Key Required"

**Solution:**
- Find the AES decryption key (see [Dealing with Encrypted PAK Files](#dealing-with-encrypted-pak-files))
- Add it in FModel Settings > AES Keys

### Issue: FModel Crashes on Loading PAK

**Possible Causes:**
- Corrupted PAK file
- Unsupported UE4 version
- Insufficient memory

**Solutions:**
- Verify game file integrity via Steam
- Update FModel to latest version
- Close other applications to free memory
- Try loading individual PAK files instead of all at once

### Issue: Exported Models Have Missing Textures

**Solution:**
- Export textures separately from the same asset folder
- Material references may need manual reassignment in 3D software
- Use FBX format which can embed material paths

### Issue: Cannot Find Specific Asset

**Solution:**
- Use FModel's search function (Ctrl+Shift+F)
- Search by asset name, type, or path
- Check different PAK files (DLC, patches may have separate PAKs)
- Some assets may have obfuscated names

### Issue: Exported Audio Has Wrong Format

**Solution:**
- Check FModel audio settings
- Some games use proprietary audio formats
- May need additional tools (vgmstream, ww2ogg)

---

## Advanced Tips

### Bulk Extraction

To extract entire folders:
1. Right-click on a folder in FModel
2. Select "Save Folder's Packages"
3. Choose format (textures, models, properties)
4. FModel will batch export all files

### Creating Asset Catalogs

1. Use FModel's "Save Properties (.json)" for assets
2. Parse JSON files to create spreadsheets/databases
3. Useful for tracking items, characters, stats

### Comparing Game Versions

1. Extract assets from different game versions/patches
2. Use diff tools to compare:
   - JSON properties for data changes
   - Image diff for texture changes
   - Model viewers for geometry changes

### Scripting with FModel

FModel supports command-line usage for automation:
```bash
FModel.exe --game="path/to/game" --export="all" --output="path/to/output"
```

Check FModel documentation for full CLI options.

---

## Resources

### Official Documentation
- FModel GitHub: https://github.com/4sval/FModel
- FModel Wiki: https://github.com/4sval/FModel/wiki
- CUE4Parse (underlying library): https://github.com/FabianFG/CUE4Parse

### Community Resources
- The Cutting Room Floor (TCRF): https://tcrf.net/Help:Contents/Finding_Content/Game_Engines/Unreal_Engine_4/FModel
- Modding.wiki FModel Guide: https://modding.wiki/en/aewff/developers/fmodel
- UE4 Modding Discord servers
- Game-specific modding communities

### Related Tools
- UE Viewer: https://www.gildor.org/en/projects/umodel
- QuickBMS: https://aluigi.altervista.org/quickbms.htm
- UAssetGUI: https://github.com/atenfyr/UAssetGUI
- Blender (for viewing/editing models): https://www.blender.org

---

## Next Steps

After extraction:
1. Document your findings in `games/dragon-quest-3-hd2d/analysis/`
2. Organize assets by type in the `assets/` folder
3. Save extraction scripts in `scripts/` for repeatability
4. Update the game's README with extraction notes
5. Consider contributing to modding communities

Happy dumping!
