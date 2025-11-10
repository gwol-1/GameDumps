# AES Key Extraction for Dragon Quest III HD-2D Remake

This guide explains how to extract the AES encryption key from Dragon Quest III HD-2D Remake to decrypt its PAK files for asset extraction.

## ⚠️ Important Notes

- **Legal Use Only:** Only extract keys from games you legally own
- **Personal Use:** For modding, research, and educational purposes only
- **Platform:** This method works only for the PC/Steam version (Windows)
- **No Redistribution:** Do not share the extracted key publicly

---

## Prerequisites

### Required Tools

1. **Steamless** - Removes Steam DRM from executable
   - Download: https://github.com/atom0s/Steamless/releases/tag/v3.1.0.0
   - Version: v3.1.0.0

2. **AES Key Finder** - Extracts AES-256 keys from executable
   - Download: https://github.com/Cracko298/AES-Key-Extracting-Guide/files/9074659/AES.Key.Finder.zip
   - Direct download from the UE4 extraction guide

3. **FModel** - For testing the extracted key
   - Download: https://github.com/4sval/FModel/releases/latest
   - Should already be installed at `../../tools/unreal-engine-4/FModel/`

### Game Files Needed

- Dragon Quest III HD-2D Remake (Steam version)
- Game installation location: `<Steam>\steamapps\common\Dragon Quest III HD-2D Remake\`

---

## Step-by-Step Process

### Step 1: Locate the Game Executable

1. Open Steam Library
2. Right-click **Dragon Quest III HD-2D Remake**
3. Select **Manage > Browse Local Files**
4. Navigate to: `Binaries\Win64\` (or `Win32` for 32-bit)
5. Find the shipping executable (likely named something like `DQIIIHD2D-Win64-Shipping.exe`)

**Expected Path:**
```
<Steam>\steamapps\common\Dragon Quest III HD-2D Remake\Binaries\Win64\DQIIIHD2D-Win64-Shipping.exe
```

*(Note: Exact executable name may vary - look for the main game .exe file)*

### Step 2: Remove Steam DRM with Steamless

1. **Extract Steamless:**
   - Download and extract Steamless to a folder (e.g., `D:\Tools\Steamless\`)

2. **Launch Steamless:**
   - Run `Steamless.exe`

3. **Select Game Executable:**
   - Click "..." button to browse
   - Navigate to the Dragon Quest III shipping executable
   - Select the .exe file

4. **Remove DRM:**
   - Click **"Unpack File"**
   - Steamless will process the executable
   - A new file will be created: `[original_name].unpacked.exe`

5. **Verify Output:**
   - Check the output folder (same location as original .exe)
   - You should see a `.unpacked.exe` file

**Example Output:**
```
DQIIIHD2D-Win64-Shipping.exe           (original, DRM-protected)
DQIIIHD2D-Win64-Shipping.unpacked.exe  (new, DRM-free)
```

### Step 3: Extract AES Key

1. **Extract AES Key Finder:**
   - Download the AES Key Finder ZIP
   - Extract to a folder (e.g., `D:\Tools\AES-Key-Finder\`)

2. **Copy Unpacked Executable:**
   - Copy `[game].unpacked.exe` to the AES Key Finder folder
   - Place it in the same directory as the batch file

3. **Run Key Finder:**
   - Double-click the batch file (`.bat`)
   - The script will scan the unpacked executable
   - Wait for it to complete

4. **Locate the Key:**
   - A new folder will be created
   - **The folder name IS the AES-256 key**
   - It will be a 64-character hexadecimal string

**Example:**
```
Folder created: 0x1A2B3C4D5E6F7A8B9C0D1E2F3A4B5C6D7E8F9A0B1C2D3E4F5A6B7C8D9E0F1A2B
                ↑
                This entire string is your AES key
```

5. **Save the Key:**
   - Copy the folder name (the hex string)
   - Save it somewhere safe (e.g., a text file in this folder)
   - **Do not share publicly**

### Step 4: Test the Key in FModel

1. **Launch FModel:**
   - Open `D:\Dev\GitHub\GameDumps\tools\unreal-engine-4\FModel\FModel.exe`

2. **Configure Game Directory:**
   - Settings > Directory Selector
   - Navigate to: `<Steam>\steamapps\common\Dragon Quest III HD-2D Remake\`
   - Or directly to: `...\DQIII HD-2D Remake\Game\Content\Paks\`
   - Click OK

3. **Add AES Key:**
   - Settings > **AES Keys**
   - Click **"Add Dynamic Key"**
   - Paste the 64-character hex key (with or without `0x` prefix)
   - Click OK

4. **Load PAK Files:**
   - FModel should now load the game's PAK files
   - You should see the directory tree on the left

5. **Verify Success:**
   - If you can browse folders and see assets → **Success!**
   - If still shows "AES Key Required" → Key may be incorrect, try again

---

## Troubleshooting

### Steamless Says "Invalid File"

**Possible Causes:**
- Wrong executable selected
- File is already unpacked
- Corrupted game files

**Solutions:**
- Verify game files via Steam (Right-click game > Properties > Local Files > Verify Integrity)
- Make sure you selected the main shipping .exe
- Try different .exe files in the Binaries folder if multiple exist

### AES Key Finder Doesn't Create Folder

**Possible Causes:**
- Batch file didn't run correctly
- Antivirus blocked the tool
- Wrong/protected executable

**Solutions:**
- Run batch file as Administrator
- Temporarily disable antivirus
- Ensure you're using the `.unpacked.exe` file
- Check console output for error messages

### FModel Still Says "AES Key Required"

**Possible Causes:**
- Key extracted incorrectly
- Game uses multiple keys
- Key format issue

**Solutions:**
- Double-check the folder name (entire 64-char hex string)
- Try with `0x` prefix: `0x[key]`
- Try without prefix: just the hex characters
- Some games have multiple PAK files with different keys - check if AES Key Finder created multiple folders

### Key is Shorter/Longer than 64 Characters

**Issue:** Standard AES-256 key should be 64 hex characters (32 bytes)

**Solutions:**
- Ensure you copied the entire folder name
- Check if there's a `0x` prefix (remove it and try)
- Some games may use different encryption - verify game engine version

---

## Alternative Method: Community Sources

If the above method doesn't work, try finding the key from modding communities:

### Where to Look

1. **Nexus Mods:**
   - Search for Dragon Quest III HD-2D Remake mods
   - Read mod descriptions/installation guides
   - Keys are sometimes mentioned in tutorials

2. **GBAtemp Forums:**
   - https://gbatemp.net
   - Search for "Dragon Quest III HD-2D" + "AES key"
   - Check ROM hacking and modding sections

3. **Reddit:**
   - r/dragonquest
   - r/moddingguides
   - r/gamemodding

4. **Discord Servers:**
   - Unreal Engine modding servers
   - Dragon Quest community servers
   - Game modding communities

**Important:** Always verify keys from community sources are legitimate and safe.

---

## After Extraction

Once you have the working AES key:

1. **Document It:**
   - Save the key in `scripts/aes-key.txt` (add to `.gitignore`)
   - Document extraction method in this README
   - Note any issues encountered

2. **Update Game README:**
   - Mark "Initial extraction" as complete
   - Add extraction date and tools used
   - Note UE4 version if discovered

3. **Begin Asset Extraction:**
   - Follow the main extraction guide: `../../tools/unreal-engine-4/EXTRACTION-GUIDE.md`
   - Start browsing assets in FModel
   - Export assets of interest

---

## Key Storage

### For Personal Use

Create a file: `scripts/aes-key.txt`
```
Dragon Quest III HD-2D Remake AES Key
Extracted: [date]
Method: Steamless + AES Key Finder

Key: 0x[64-character hex string]
```

### For Git Repository

**DO NOT commit the key to GitHub!**

Add to `.gitignore`:
```
# AES Keys (do not commit)
**/aes-key.txt
scripts/aes-key.txt
```

---

## Finding Game Version

You may need the Unreal Engine version for FModel:

1. **Check Executable Properties:**
   - Right-click original `Shipping.exe` (not unpacked)
   - Properties > Details > File Version
   - Look for UE version info

2. **Check PAK Files:**
   - FModel usually auto-detects UE version
   - Can also check PAK file headers

3. **Community Sources:**
   - PCGamingWiki
   - Game forums/subreddits

---

## Reference Links

- **Original Guide:** https://github.com/Cracko298/UE4-AES-Key-Extracting-Guide
- **Steamless:** https://github.com/atom0s/Steamless
- **FModel:** https://github.com/4sval/FModel
- **Main Extraction Guide:** `../../tools/unreal-engine-4/EXTRACTION-GUIDE.md`

---

## Legal & Ethical Reminder

This process is for:
- ✓ Personal modding and customization
- ✓ Educational research
- ✓ Game preservation
- ✓ Asset analysis for learning

This process is NOT for:
- ✗ Piracy or DRM circumvention for illegal copies
- ✗ Commercial use without permission
- ✗ Redistribution of copyrighted assets
- ✗ Violating the game's EULA/Terms of Service

**Always respect intellectual property and use responsibly.**

---

*Last Updated: 2025-11-10*
*Method Source: Cracko298's UE4 AES Key Extracting Guide*
