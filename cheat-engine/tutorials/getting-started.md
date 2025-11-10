# Cheat Engine - Getting Started Tutorial

Based on official CE Wiki tutorials and guides.

**Source:** https://wiki.cheatengine.org/index.php?title=Tutorials

---

## What is Cheat Engine?

Cheat Engine is a development environment focused on modding games and applications for personal use. It allows you to scan and modify memory values in running processes.

## Prerequisites

- Cheat Engine 7.6 installed
- A game or application to practice on
- Administrator privileges

## Built-In Tutorial

**Best way to learn:** Use CE's built-in tutorial!

1. Open Cheat Engine
2. Click **Help** > **Cheat Engine Tutorial**
3. Complete Steps 1-9 to learn:
   - Finding exact values
   - Unknown values
   - Floating points
   - Code injection
   - Pointers
   - Code finding

---

## Core Concepts

### 1. Value Types

**Cheat Engine supports various data types:**

| Type | Description | Example Use |
|------|-------------|-------------|
| **Byte** | 8-bit (0-255) | Small counters, flags |
| **2 Bytes** | 16-bit | Health in older games |
| **4 Bytes** | 32-bit integer | Gold, score, most values |
| **8 Bytes** | 64-bit | Large numbers, modern games |
| **Float** | Decimal numbers | Speed, percentages |
| **Double** | High-precision decimal | Coordinates, physics |
| **String** | Text | Player names, item names |
| **Array of Bytes (AOB)** | Code patterns | Code injection |

### 2. Pointers

**What are pointers?**
- Memory addresses that point to other addresses
- Used because game values move in memory
- Pointer chains lead to stable base addresses

**Why use pointers?**
- Game restarts change addresses
- Pointers remain valid across restarts
- Essential for permanent cheats

**Pointer notation:**
```
[Base Address] + Offset1 → [Address2] + Offset2 → [Final Value]
```

### 3. The Stack

**What is the stack?**
- Temporary memory storage
- Used for function calls and local variables
- Important for code injection

### 4. AOBs (Array of Bytes)

**What are AOBs?**
- Unique byte patterns in game code
- Used to find code regardless of address
- Essential for game updates

**Example AOB:**
```
89 0E 8B 45 FC 83 C0 01
```

---

## Basic Workflow

### Step 1: Attach to Process

1. **Launch Cheat Engine**
2. **Click the computer icon** (top-left)
3. **Select your game** from the process list
4. **Click "Open"**

### Step 2: First Value Scan

**Example: Finding health value of 100**

1. **Select value type:** 4 Bytes
2. **Enter value:** 100
3. **Click "First Scan"**
4. **Result:** List of addresses with value 100

### Step 3: Next Scan (Filter)

1. **Change health in-game** (take damage)
2. **Enter new value:** 75
3. **Click "Next Scan"**
4. **Result:** Fewer addresses

**Repeat until you have 1-5 addresses**

### Step 4: Modify Value

1. **Double-click an address** to add to address list
2. **Double-click the value** in address list
3. **Change to 999**
4. **Press Enter**
5. **Check in-game!**

### Step 5: Freeze Value

1. **Check the box** next to the address
2. Value will be locked at that number
3. Uncheck to unfreeze

---

## Finding Different Value Types

### Exact Values (Known)

**Use when you know the exact value**

Example: Gold = 1500
```
1. Value Type: 4 Bytes
2. Scan Type: Exact Value
3. Value: 1500
4. First Scan
5. Change gold in-game
6. Next Scan with new value
```

### Unknown Initial Value

**Use when you don't know the exact value**

Example: Finding stamina
```
1. Value Type: 4 Bytes (or Float)
2. Scan Type: Unknown initial value
3. First Scan
4. Use stamina in-game
5. Scan Type: Decreased Value
6. Next Scan
7. Wait for stamina to recover
8. Scan Type: Increased Value
9. Repeat until few addresses remain
```

### Floating Point Values

**Use for decimals (speed, coordinates)**

Example: Movement speed
```
1. Value Type: Float or Double
2. Follow same process as 4 Bytes
3. May need to round (e.g., 1.5 or 1.500000)
```

---

## Working with Addresses

### Address List

**Bottom panel of CE window**

**Functions:**
- Store found addresses
- Modify values
- Freeze values
- Add descriptions
- Group related cheats

**Right-click options:**
- Change value
- Change description
- Browse this memory region
- Find out what accesses/writes to this address
- Find out what this pointer points to

### Memory Viewer

**Access:** Memory View button or Ctrl+M

**Features:**
- View memory as hex
- Disassemble code
- Set breakpoints
- Modify assembly code
- View strings

---

## Code Injection Basics

### What is Code Injection?

Injecting your own code into the game's code to:
- Intercept value changes
- Modify game behavior
- Create advanced cheats

### Find What Writes

1. **Add address to list**
2. **Right-click** > "Find out what writes to this address"
3. **Trigger the write in-game** (e.g., take damage)
4. **CE shows the code** that modifies this address

### Auto Assembler

**Access:** Tools > Auto Assembler (Ctrl+A)

**Templates:**
- Code Injection
- AOB Injection
- Full Injection

**Example: Infinite Health**
```assembly
// Original code that decreases health
sub [rbx+10],eax

// Replace with:
// mov [rbx+10],#999  // Set health to 999
// Original code
sub [rbx+10],eax
```

---

## Pointer Scanning

### Why Scan for Pointers?

- Game restarts change memory addresses
- Pointers lead to static base addresses
- Creates permanent cheats

### How to Pointer Scan

1. **Find the value address** (e.g., health)
2. **Right-click** > "Pointer scan for this address"
3. **Wait for scan** to complete
4. **Save pointer scan** file
5. **Restart game**
6. **Rescan pointer map** with new address
7. **Result:** Valid pointers that survive restarts

### Pointer Notation

```
"GameName.exe"+00123456
  +10
  +20
  +4C → [Your Value]
```

This means:
```
[GameName.exe base + 0x123456] + 0x10 → Address A
[Address A] + 0x20 → Address B
[Address B] + 0x4C → Your Health Value
```

---

## Cheat Tables (.CT Files)

### What are Cheat Tables?

- Saved CE sessions
- Contain addresses, scripts, pointers
- Shareable with others

### Creating a Table

1. **Add addresses** to address list
2. **Add descriptions**
3. **Add scripts** if using code injection
4. **File** > **Save As** > "GameName.CT"

### Using Downloaded Tables

1. **Download** .CT file
2. **Open Cheat Engine**
3. **File** > **Load** > Select .CT file
4. **Attach to game process**
5. **Enable cheats** by checking boxes

### Table Structure

```
[ENABLE]
// Code that activates the cheat
[DISABLE]
// Code that deactivates the cheat
```

---

## Tips for Success

### ✅ Do:
- Start with the built-in tutorial (Step 1-9)
- Use exact value scans when possible
- Add descriptions to addresses
- Save your work as .CT files
- Test on single-player games first

### ❌ Don't:
- Use on multiplayer/online games
- Modify values too extremely (may crash)
- Forget to backup saves
- Skip the tutorial steps

---

## Next Steps

1. **Complete CE Tutorial** (Help > CE Tutorial)
2. **Practice on simple games** (offline indie games)
3. **Learn Auto Assembler** (see auto-assembler.md)
4. **Learn Lua Scripting** (see lua-basics.md)
5. **Explore CE Wiki** for advanced topics

---

## Additional Resources

### Official CE Resources
- **CE Tutorial Guide (x32):** https://wiki.cheatengine.org/index.php?title=Tutorials:Cheat_Engine_Tutorial_Guide_x32
- **CE Tutorial Guide (x64):** https://wiki.cheatengine.org/index.php?title=Tutorials:Cheat_Engine_Tutorial_Guide_x64
- **Value Types:** https://wiki.cheatengine.org/index.php?title=Tutorials:Value_types
- **Pointers:** https://wiki.cheatengine.org/index.php?title=Tutorials:Pointers

### Video Tutorials
- Search YouTube for "Cheat Engine Tutorial"
- CE Forums have video sections

### Community
- **CE Forums:** https://forum.cheatengine.org
- **r/cheatengine:** https://reddit.com/r/cheatengine

---

## Troubleshooting

**CE won't attach to process:**
- Run CE as Administrator
- Disable anti-cheat (single-player only)
- Update CE to latest version

**Can't find value:**
- Try different value types (Float vs 4 Bytes)
- Value might be encrypted (multiply by 8, etc.)
- Use unknown initial value scan

**Found value but it doesn't work:**
- Might be a display value, not actual value
- Try "Find what writes" to find real address
- Game might have anti-cheat

**Pointer scan takes forever:**
- Reduce heap size
- Increase max level
- Use faster storage (SSD)

---

**Practice makes perfect! Start with the built-in tutorial and work your way up.**

*Based on official Cheat Engine Wiki - https://wiki.cheatengine.org*
