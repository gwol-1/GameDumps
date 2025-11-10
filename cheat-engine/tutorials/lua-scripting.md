# Lua Scripting in Cheat Engine

Learn to automate CE tasks and create custom UI with Lua.

**Based on:** CE Wiki Lua Tutorials
**Source:** https://wiki.cheatengine.org/index.php?title=Tutorials

---

## What is Lua?

Lua is a lightweight scripting language built into Cheat Engine. Use it to:
- Automate repetitive tasks
- Create custom forms and UI
- Handle complex logic
- Build trainers
- Auto-attach to processes

---

## Accessing Lua

**Method 1: Lua Engine Window**
- Menu: **Table** > **Show Cheat Table Lua Script**
- This script runs when table loads

**Method 2: Cheat Table Scripts**
- Right-click address > **Set/Change script**
- Add `[ENABLE]` and `[DISABLE]` sections

**Method 3: Execute Lua**
- Memory Viewer > **Tools** > **Lua Engine**

---

## Lua Basics

### Variables

```lua
-- Numbers
local health = 100
local speed = 1.5

-- Strings
local playerName = "Hero"
local message = 'Hello'

-- Booleans
local isAlive = true
local hasKey = false

-- Tables (arrays/objects)
local items = {sword", "shield", "potion"}
local player = {name="Hero", hp=100, level=5}
```

### Functions

```lua
function addNumbers(a, b)
  return a + b
end

local result = addNumbers(5, 3)  -- result = 8
```

### Conditionals

```lua
if health > 50 then
  print("Healthy")
elseif health > 0 then
  print("Injured")
else
  print("Dead")
end
```

### Loops

```lua
-- For loop
for i=1, 10 do
  print(i)
end

-- While loop
local count = 0
while count < 5 do
  count = count + 1
end

-- For each
local items = {"sword", "shield"}
for index, item in ipairs(items) do
  print(index, item)
end
```

---

## CE-Specific Lua Functions

### Process Functions

```lua
-- Open/attach to process
openProcess("game.exe")

-- Get process ID
local pid = getOpenedProcessID()

-- Check if process is open
if process == nil then
  print("No process attached")
end
```

### Memory Functions

```lua
-- Read memory
local address = 0x12345678
local value = readInteger(address)
local floatValue = readFloat(address)
local stringValue = readString(address, 50)

-- Write memory
writeInteger(address, 999)
writeFloat(address, 1.5)
writeString(address, "NewName")

-- Read with offsets
local base = getAddress("game.exe")
local health = readInteger(base + 0x1000)
```

### Address Functions

```lua
-- Get module base
local base = getAddress("game.exe")
local dllBase = getAddress("GameLogic.dll")

-- Symbol lookup
local addr = getAddressSafe("game.exe+12345")

-- Allocate memory
local newmem = allocateMemory(1024)
```

### Scanning

```lua
-- Memory scan
local results = AOBScan("89 0E 8B 45 FC")
if results then
  local address = tonumber(results[0], 16)
  print(string.format("Found at: %X", address))
end
```

---

## Auto-Attach Script

Automatically attach to game when table loads.

```lua
-- Add to Table Lua Script

-- Check if process is already open
if process ~= nil then
  closeCE()
end

-- Try to open process
local success = openProcess("GameName.exe")

if not success then
  -- Process not found, start timer to keep trying
  local timer = createTimer(nil)
  timer.Interval = 1000  -- Check every second

  timer.OnTimer = function()
    if openProcess("GameName.exe") then
      print("Successfully attached to GameName.exe")
      timer.destroy()
    end
  end
else
  print("Attached to GameName.exe")
end
```

---

## Creating Forms and UI

### Simple Message Box

```lua
showMessage("Cheat activated!")
```

### Input Dialog

```lua
local input = inputQuery("Enter value", "Enter your gold amount:", "1000")
if input then
  local goldAddr = 0x12345678
  writeInteger(goldAddr, tonumber(input))
end
```

### Custom Form

```lua
-- Create form
local form = createForm()
form.Caption = "My Trainer"
form.Width = 400
form.Height = 300

-- Add button
local button = createButton(form)
button.Caption = "Add Gold"
button.Left = 50
button.Top = 50
button.OnClick = function()
  local goldAddr = 0x12345678
  writeInteger(goldAddr, 999999)
  showMessage("Gold added!")
end

-- Add label
local label = createLabel(form)
label.Caption = "Click to add gold"
label.Left = 50
label.Top = 20

-- Show form
form.show()
```

---

## Practical Examples

### Example 1: Hotkey System

```lua
function registerHotkeys()
  -- F1 = Add Health
  createHotkey(function()
    local healthAddr = 0x12345678
    writeInteger(healthAddr, 999)
    showMessage("Health restored!")
  end, VK_F1)

  -- F2 = Add Gold
  createHotkey(function()
    local goldAddr = 0x87654321
    writeInteger(goldAddr, 999999)
    showMessage("Gold added!")
  end, VK_F2)
end

registerHotkeys()
```

### Example 2: Value Monitor

```lua
-- Monitor health and alert when low
local healthAddr = 0x12345678
local timer = createTimer(nil)
timer.Interval = 1000  -- Check every second

timer.OnTimer = function()
  local health = readInteger(healthAddr)
  if health < 20 then
    showMessage("WARNING: Low health!")
    playSound(beepSound())
  end
end
```

### Example 3: Address List Automation

```lua
-- Add multiple addresses at once
local addresses = {
  {desc="Health", addr=0x12345678, type=vtDword},
  {desc="Mana", addr=0x1234567C, type=vtDword},
  {desc="Gold", addr=0x12345680, type=vtDword},
  {desc="Level", addr=0x12345684, type=vtWord}
}

for _, item in ipairs(addresses) do
  local record = addresslist_createMemoryRecord(getAddressList())
  record.Description = item.desc
  record.Address = string.format("%X", item.addr)
  record.Type = item.type
end
```

### Example 4: Pointer Path Finder

```lua
-- Helper to add pointer
function addPointer(desc, base, offsets)
  local record = addresslist_createMemoryRecord(getAddressList())
  record.Description = desc
  record.IsPointer = true
  record.Address = base

  -- Add offsets
  for i, offset in ipairs(offsets) do
    record.Offsets[i-1] = offset
  end

  return record
end

-- Usage
addPointer("Player Health", "game.exe+12345", {0x10, 0x4, 0x2C})
```

---

## CE Object Model

### Main Objects

```lua
-- Address List
local al = getAddressList()
local record = al.getMemoryRecord(0)  -- Get first record

-- Memory Records
record.Description = "Health"
record.Address = "12345678"
record.Value = "999"
record.Active = true  -- Freeze

-- Main Form
local mf = getMainForm()
mf.Caption = "Custom Title"

-- Memory Viewer
local mv = getMemoryViewForm()
mv.DisassemblerView.SelectedAddress = 0x12345678
```

### Creating Memory Records

```lua
local mr = addresslist_createMemoryRecord(getAddressList())
mr.Description = "Player Gold"
mr.Address = "game.exe+A1B2C3"
mr.Type = vtDword
mr.Script = [[
[ENABLE]
// Script here
[DISABLE]
// Restore here
]]
```

---

## Debugging Lua Scripts

### Print Debugging

```lua
print("Value:", value)
print(string.format("Address: %X", address))
```

### Error Handling

```lua
local success, error = pcall(function()
  -- Your risky code here
  local value = readInteger(0x12345678)
end)

if not success then
  print("Error:", error)
end
```

### Lua Engine Window

- View output
- Test code interactively
- Debug errors

---

## Best Practices

### ✅ Do:
- Use `local` for variables (avoid globals)
- Add comments to explain logic
- Handle errors with pcall
- Test scripts incrementally
- Use meaningful variable names

### ❌ Don't:
- Overuse global variables
- Create memory leaks (destroy timers/forms)
- Forget to check if process is attached
- Make infinite loops without sleep

---

## Advanced Topics

### Object-Oriented Programming

```lua
Player = {}
Player.__index = Player

function Player:new(name, health)
  local obj = setmetatable({}, self)
  obj.name = name
  obj.health = health
  return obj
end

function Player:heal(amount)
  self.health = self.health + amount
end

local hero = Player:new("Hero", 100)
hero:heal(50)
```

### Module System

```lua
-- myModule.lua
local M = {}

function M.addGold(amount)
  local goldAddr = 0x12345678
  local current = readInteger(goldAddr)
  writeInteger(goldAddr, current + amount)
end

return M

-- In main script
local myMod = require("myModule")
myMod.addGold(1000)
```

---

## CE Lua API Reference

**Full documentation:** https://wiki.cheatengine.org/index.php?title=Lua

### Memory

| Function | Description |
|----------|-------------|
| `readBytes(addr, count)` | Read bytes |
| `writeBytes(addr, table)` | Write bytes |
| `readInteger(addr)` | Read 4-byte int |
| `readFloat(addr)` | Read float |
| `readString(addr, len)` | Read string |

### Process

| Function | Description |
|----------|-------------|
| `openProcess(name)` | Attach to process |
| `getAddress(module)` | Get module base |
| `injectDLL(path)` | Inject DLL |

### UI

| Function | Description |
|----------|-------------|
| `createForm()` | New form |
| `createButton(parent)` | New button |
| `createLabel(parent)` | New label |
| `showMessage(text)` | Message box |

---

## Resources

### Official Documentation
- **Lua API:** https://wiki.cheatengine.org/index.php?title=Lua
- **CE Classes:** https://wiki.cheatengine.org/index.php?title=Classes
- **Lua Basics:** https://wiki.cheatengine.org/index.php?title=Tutorials:Lua_Basics

### Learning Lua
- **Lua Manual:** https://www.lua.org/manual/5.4/
- **Learn Lua in Y Minutes:** https://learnxinyminutes.com/docs/lua/

### Community
- **CE Forums Lua Section:** https://forum.cheatengine.org/viewforum.php?f=8

---

*Lua makes CE incredibly powerful - master it to create amazing tools!*

*Based on CE Wiki - https://wiki.cheatengine.org*
