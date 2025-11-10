# Cheat Engine Installation

## Quick Install

### Download Cheat Engine 7.6 (Latest)

**Official Download:** https://www.cheatengine.org/downloads.php

1. Visit the official CE website
2. Download `CheatEngine76.exe`
3. Install or extract to this folder
4. Run `CheatEngine.exe`

## Installation Notes

⚠️ **Antivirus Warning:**
- Some AV software flags CE as malware (false positive)
- Temporarily disable AV if needed during installation
- CE is safe from official site

## After Installation

Your folder structure should look like:
```
tools/cheat-engine/
├── README.md (this file)
├── CheatEngine.exe
├── cheatengine-x86_64.exe
└── [other CE files]
```

## Usage

### Basic Workflow
1. Launch CheatEngine.exe
2. Click computer icon to attach to game process
3. Search for values (health, gold, etc.)
4. Modify found addresses
5. Save as .CT table file

### With GameDumps
Use extracted game data to find values faster:
- Check `games/[game]/analysis/asset-catalogs/cheat-engine/`
- Use JSON data as reference for IDs and values
- Create tables in `games/[game]/analysis/asset-catalogs/cheat-engine/[game]-tables/`

## Resources

See main CE guide: `../../cheat-engine/README.md`

---

**Latest Version:** 7.6 (Feb 12, 2025)
**Official Site:** https://cheatengine.org
