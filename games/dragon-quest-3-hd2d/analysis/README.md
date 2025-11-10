# Dragon Quest III HD-2D Remake - Analysis Folder

This folder contains research, documentation, and findings from the game dump extraction.

## Directory Structure

### `screenshots/`
Visual documentation and references organized by purpose.

#### `fmodel-structure/`
- FModel interface screenshots
- Folder tree navigation
- PAK file structure
- Directory organization
- Useful for documenting where assets are located

**Example filenames:**
- `content-folder-overview.png`
- `ui-folder-structure.png`
- `character-assets-location.png`

#### `asset-previews/`
- Previews of textures, models, UI elements
- Screenshots from FModel's preview pane
- Interesting assets discovered
- Asset comparisons

**Example filenames:**
- `character-portrait-hero.png`
- `item-icon-sword.png`
- `ui-menu-main.png`

#### `game-reference/`
- In-game screenshots for comparison
- Used to verify extracted assets match in-game appearance
- Context for asset usage

**Example filenames:**
- `ingame-battle-ui.png`
- `ingame-character-screen.png`
- `ingame-world-map.png`

### `asset-catalogs/`
Organized lists and inventories of game assets.

**Examples:**
- `texture-inventory.csv` - List of all textures with sizes, paths
- `character-models.md` - Documentation of character assets
- `ui-elements.md` - Catalog of UI components
- `item-list.json` - Exported item data tables

### `cheat-engine/` (optional)
Cheat Engine research and tables.

**Contents:**
- `.CT` files (Cheat Engine tables)
- `item-ids.txt` - Item ID reference from data tables
- `memory-addresses.md` - Documented addresses
- Screenshots of CE research

### `notes.md`
General findings, observations, and research notes that don't fit elsewhere.

## Usage Guidelines

### Screenshot Naming Convention
Use descriptive, lowercase names with hyphens:
- ✅ `fmodel-character-folder-overview.png`
- ✅ `asset-hero-sprite-front.png`
- ✅ `ui-battle-menu-layout.png`
- ❌ `Screenshot1.png`
- ❌ `IMG_20251110.png`

### File Size Considerations
- Keep screenshots reasonable size (< 2MB each)
- Use PNG for UI/text (better quality)
- Use JPG for in-game screenshots (smaller size)
- Compress if needed for git repo

### Git Commit Policy
- ✅ Screenshots ARE committed (they're documentation)
- ✅ Asset catalogs and lists ARE committed
- ✅ Analysis notes and findings ARE committed
- ❌ Large extracted assets (textures, models) are NOT committed (gitignored)

## Tips

### Taking Good FModel Screenshots
1. **Folder Structure:** Expand relevant folders, capture the tree view
2. **Asset Previews:** Click asset, wait for preview to load, capture both file list and preview pane
3. **Include Context:** Show enough of the interface to understand what you're looking at

### Documenting Findings
1. Take screenshot first
2. Note the file path in FModel
3. Add description in a markdown file
4. Reference screenshot by filename

### Building Asset Catalogs
1. Export data tables as JSON (not screenshots)
2. Create markdown or CSV files listing assets
3. Reference screenshots for visual examples
4. Keep organized by asset type

---

*This folder structure helps maintain organized research and makes it easy to reference findings later.*
