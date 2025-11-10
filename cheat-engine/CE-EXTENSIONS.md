# Cheat Engine Extensions & Plugins

Community-developed tools that enhance Cheat Engine functionality.

**Source:** CE Extensions Forum - https://forum.cheatengine.org/viewforum.php?f=130

---

## What are CE Extensions?

Extensions are custom tools, scripts, and plugins created by the CE community that add new features and improve workflow.

---

## Where to Find Extensions

**CE Extensions Forum:** https://forum.cheatengine.org/viewforum.php?f=130

This is the official forum section where developers share their extensions. Most are free to download and use.

---

## Popular Extension Categories

### 1. **Lua Script Extensions**

**AAmaker [Lua plugin]**
- Highly active (32+ replies)
- Auto Assembler script generation
- Simplifies code injection creation

**Mono/IL2CPP Tools**
- Class inspection for Unity games
- Managed code analysis
- Useful for modern game engines

### 2. **UI Enhancements**

**Form & Control Customization**
- Custom UI builders
- Color crafting utilities
- Font size adjustments
- Tab layout modifications

**Dropdown Menu Lists Editor** (18 replies)
- Create custom dropdown menus
- Improve cheat table usability

### 3. **Debugging & Analysis**

**Structure Dissection Utilities**
- Analyze complex data structures
- Visualize memory layouts

**Memory Dumpers**
- Godot engine support
- Custom engine dumpers
- Extract game data

**C Header Converter**
- Convert CE structures to C headers
- Useful for external tool development

### 4. **Automation Tools**

**Auto-Updating Cheat Tables**
- Tables that update themselves
- Survive game patches

**Hotkey Management**
- Advanced hotkey systems
- Multi-key combinations

**Process Reattachment**
- Auto-reattach on game restart
- Seamless workflow

### 5. **Development Tools**

**CE Script Editor [Notepad++]** (27 replies)
- Syntax highlighting for CE scripts
- External editor integration
- Better code editing experience

**AOB Scanning Utilities**
- Find unique byte patterns
- Generate AOB injection code

**Custom Printers**
- Faster performance than default
- Custom output formatting

---

## How to Install Extensions

### Method 1: Lua Scripts

1. **Download** the .lua file
2. **Place** in CE Lua scripts folder
3. **Load** via Table > Show Cheat Table Lua Script
4. **Add:** `require('extensionName')`

### Method 2: DLL Plugins

1. **Download** the .dll file
2. **Place** in CE installation folder
3. **Restart** Cheat Engine
4. Extension should auto-load

### Method 3: Manual Load

1. **Open** Lua Engine (Ctrl+L)
2. **Execute:** `dofile('path/to/extension.lua')`
3. Or **paste** code directly

---

## Notable Extensions

### For Unity Games

**Mono Features**
- Built into CE 7.6
- Inspect C# classes
- View managed heap

**IL2CPP Support**
- Work with IL2CPP Unity games
- Class dumping
- Method finding

### For Unreal Engine

**UE4 Dumpers**
- Find UE4 structures
- Name table extraction
- Object browser

### For Code Analysis

**IDA Integration**
- Export to IDA Pro
- Better disassembly
- Cross-reference with IDA

---

## Creating Your Own Extensions

### Basic Lua Extension Template

```lua
-- myExtension.lua
local extension = {}

function extension.init()
  print("Extension loaded!")

  -- Add menu item
  local menu = getMainForm().Menu
  local item = createMenuItem(menu)
  item.Caption = "My Extension"
  item.OnClick = function()
    showMessage("Extension activated!")
  end
  menu.Items.add(item)
end

-- Auto-init when loaded
extension.init()

return extension
```

### Packaging for Distribution

1. **Test thoroughly**
2. **Add comments and documentation**
3. **Create README**
4. **Post on CE forums** with description
5. **Provide example usage**

---

## Extension Best Practices

### ✅ Do:
- Document your extension
- Provide usage examples
- Test on different CE versions
- Handle errors gracefully
- Use meaningful names

### ❌ Don't:
- Modify core CE files
- Use excessive global variables
- Forget to clean up (timers, forms)
- Release untested code

---

## Security Note

⚠️ **Download extensions only from trusted sources:**
- Official CE Forums
- Known developers
- Reputable sites

**Always review code before running**
- Lua scripts are text - read them!
- Check for suspicious activity
- Use antivirus scan

---

## Contributing Extensions

### Share Your Work

1. **Post on CE Forums:** https://forum.cheatengine.org/viewforum.php?f=130
2. **Include:**
   - Clear description
   - Usage instructions
   - Screenshots/examples
   - Version compatibility
3. **Respond to feedback**
4. **Update as needed**

---

## Resources

### CE Extensions Forum
**URL:** https://forum.cheatengine.org/viewforum.php?f=130
- Browse existing extensions
- Request new features
- Share your creations

### Documentation
- **Lua API:** https://wiki.cheatengine.org/index.php?title=Lua
- **Classes:** https://wiki.cheatengine.org/index.php?title=Classes

### Community
- **CE Discord:** (link in forums)
- **r/cheatengine:** Reddit community

---

## Popular Extension Authors

Check their forum profiles for more tools:
- **atom0s** (Forum moderator, many contributions)
- **Dark Byte** (CE creator, official plugins)
- **mgr.inz.Player** (Various utilities)
- Other active contributors in Extensions forum

---

*Extensions make CE even more powerful - explore and contribute!*

*Based on CE Extensions Forum - https://forum.cheatengine.org/viewforum.php?f=130*
