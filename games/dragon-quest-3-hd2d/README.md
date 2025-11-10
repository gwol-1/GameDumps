# Dragon Quest III HD-2D Remake

## Game Information

- **Title:** Dragon Quest III HD-2D Remake
- **Developer:** Square Enix / Artdink
- **Publisher:** Square Enix
- **Release Date:** November 14, 2024
- **Platform:** PC / Console
- **Engine:** Unreal Engine 4
- **Engine Version:** (To be determined)

## Dump Status

- [ ] Initial extraction
- [ ] Asset identification
- [ ] Texture extraction
- [ ] Model extraction
- [ ] Audio extraction
- [ ] Script/text extraction
- [ ] Analysis complete

## Directory Contents

### `extracted/`
Raw files extracted directly from the game installation or pak files.

### `assets/`
Processed and converted assets:
- Textures (converted to standard formats)
- 3D models (converted to obj/fbx/etc)
- Audio files (converted to wav/mp3)
- Other converted assets

### `scripts/`
Scripts and tools used for extraction and processing:
- Extraction scripts
- Conversion tools
- Automation scripts

### `analysis/`
Documentation and findings:
- File format documentation
- Asset catalogs
- Technical notes
- Screenshots/references

## Getting Started

### Prerequisites

1. **Extract AES Decryption Key** (Required)
   - Follow the guide: [`AES-KEY-EXTRACTION.md`](AES-KEY-EXTRACTION.md)
   - Uses Steamless + AES Key Finder method
   - Save key to `scripts/aes-key.txt` (not committed to git)

2. **Install FModel**
   - Download from: https://github.com/4sval/FModel/releases/latest
   - Extract to: `../../tools/unreal-engine-4/FModel/`
   - Follow setup guide: `../../tools/unreal-engine-4/EXTRACTION-GUIDE.md`

3. **Begin Extraction**
   - Configure FModel with game directory
   - Add AES key to FModel settings
   - Browse and extract assets

## Extraction Notes

### Tools Used
- **FModel** - Primary asset extraction tool
- **Steamless** - Remove Steam DRM from executable
- **AES Key Finder** - Extract encryption key from unpacked executable

### Game File Location
**Steam Installation Path:**
```
<Steam>\steamapps\common\Dragon Quest III HD-2D Remake\
```

**Shipping Executable:**
```
Binaries\Win64\DQIIIHD2D-Win64-Shipping.exe
```
*(Note: Exact name may vary)*

**PAK Files Location:**
```
Game\Content\Paks\
```

### Pak File Structure
- **Encryption:** AES-256 encrypted (requires key extraction)
- **Files:** (To be documented after extraction)

## Findings

### Assets of Interest
- (Document interesting assets discovered)

### File Formats
- (Document custom or unusual file formats)

### Technical Details
- (Engine-specific details, rendering techniques, etc.)

## References

- [UE4 Tools](../../tools/unreal-engine-4/)
- (Add other reference links)
