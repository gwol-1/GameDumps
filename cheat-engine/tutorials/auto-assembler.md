# Auto Assembler Tutorial

Learn code injection and assembly scripting for advanced game modifications.

**Based on:** CE Wiki Auto Assembler Tutorials
**Source:** https://wiki.cheatengine.org/index.php?title=Tutorials

---

## What is Auto Assembler?

Auto Assembler is Cheat Engine's built-in assembler and scripting language that allows you to:
- Inject custom code into games
- Modify game behavior
- Create complex cheats
- Use templates for common tasks

---

## Accessing Auto Assembler

**Method 1:**
- Menu: **Tools** > **Auto Assembler**
- Hotkey: **Ctrl+A**

**Method 2:**
- Memory Viewer > **Tools** > **Auto Assembler**

---

## Auto Assembler Basics

### Structure of a Script

```assembly
[ENABLE]
// Code that runs when you enable the cheat

[DISABLE]
// Code that restores original code when disabled
```

### Example: Simple NOP (No Operation)

```assembly
[ENABLE]
"game.exe"+12345:
  nop  // Do nothing instead of original code
  nop

[DISABLE]
"game.exe"+12345:
  sub [rax],ebx  // Original code
```

### Comments

```assembly
// Single line comment

/* Multi-line
   comment */
```

---

## Templates

CE provides templates for common injection types.

**Access:** Auto Assembler Window > **Template** > Select type

### 1. Code Injection

**When to use:** Modify a specific piece of code

**How it works:**
- Finds the code address
- Jumps to your custom code
- Executes your code
- Returns to original code

**Template generates:**
```assembly
[ENABLE]
alloc(newmem,2048)
label(returnhere)
label(originalcode)
label(exit)

newmem: //this is allocated memory

  // YOUR CODE HERE

originalcode:
  sub [rax],ebx  // Original instruction

exit:
  jmp returnhere

"game.exe"+12345:
  jmp newmem
returnhere:

[DISABLE]
dealloc(newmem)
"game.exe"+12345:
  sub [rax],ebx  // Restore original code
```

### 2. AOB Injection

**When to use:** When addresses change between game versions

**How it works:**
- Searches for unique byte pattern
- Injects code at found location
- Survives game updates

**Template:**
```assembly
[ENABLE]
aobscanmodule(INJECT,game.exe,89 0E 8B 45 FC)
alloc(newmem,2048)

newmem:
  // YOUR CODE

originalcode:
  mov [rsi],ecx

exit:
  jmp returnhere

INJECT:
  jmp newmem
returnhere:

[DISABLE]
dealloc(newmem)
INJECT:
  mov [rsi],ecx
```

### 3. Full Injection

**When to use:** Complete control over code flow

**More advanced:** Includes registers, call handling, etc.

---

## Working with Integers

### Freezing a Value

**Example: Infinite Health (freeze at 999)**

```assembly
[ENABLE]
alloc(newmem,256)
label(returnhere)
label(originalcode)

newmem:
  mov [rbx+10],#999  // Force health to 999
  jmp returnhere

"game.exe"+12345:
  jmp newmem
  nop  // Fill remaining bytes
returnhere:

originalcode:
  sub [rbx+10],eax  // Original: decrease health

[DISABLE]
dealloc(newmem)
"game.exe"+12345:
  sub [rbx+10],eax  // Restore original
```

### Multiplying Values

**Example: 2x Experience Gain**

```assembly
[ENABLE]
alloc(newmem,256)
label(returnhere)

newmem:
  imul eax,2  // Multiply by 2
  add [rcx+20],eax
  jmp returnhere

"game.exe"+54321:
  jmp newmem
returnhere:

[DISABLE]
dealloc(newmem)
"game.exe"+54321:
  add [rcx+20],eax  // Original
```

---

## Working with Floats

### Modifying Float Values

**Example: Increased Movement Speed**

```assembly
[ENABLE]
alloc(newmem,256)
label(returnhere)

newmem:
  mulss xmm0,[speedMultiplier]  // Multiply speed
  movss [rbx+50],xmm0
  jmp returnhere

speedMultiplier:
  dd (float)2.5  // 2.5x speed

"game.exe"+98765:
  jmp newmem
returnhere:

[DISABLE]
dealloc(newmem)
"game.exe"+98765:
  movss [rbx+50],xmm0  // Original
```

---

## Three Levels of Injection

Based on CE Wiki's three practical examples:

### Level 1: Basic Code Injection

**Purpose:** Replace one instruction

**Example:**
```assembly
[ENABLE]
"game.exe"+12345:
  mov [rax],#1000  // Set value to 1000

[DISABLE]
"game.exe"+12345:
  sub [rax],ebx  // Restore original
```

### Level 2: Code Cave Injection

**Purpose:** Add multiple instructions

**Example:**
```assembly
[ENABLE]
alloc(newmem,256)

newmem:
  mov [rax],#1000
  add [rcx],#100
  mov [rdx],#50
  jmp returnhere

"game.exe"+12345:
  jmp newmem
returnhere:

[DISABLE]
dealloc(newmem)
"game.exe"+12345:
  sub [rax],ebx
```

### Level 3: Full Injection with Conditional Logic

**Purpose:** Complex modifications

**Example: Only modify if specific condition**
```assembly
[ENABLE]
alloc(newmem,512)

newmem:
  cmp [rax],#100      // Check if value < 100
  jl skip             // If less, skip modification

  mov [rax],#999      // Set to 999

skip:
  sub [rax],ebx       // Original code
  jmp returnhere

"game.exe"+12345:
  jmp newmem
returnhere:

[DISABLE]
dealloc(newmem)
"game.exe"+12345:
  sub [rax],ebx
```

---

## Common Auto Assembler Commands

### Memory Allocation

```assembly
alloc(name, size)              // Allocate memory
dealloc(name)                  // Free allocated memory
```

### Labels

```assembly
label(labelname)               // Define a label
labelname:                     // Use the label
```

### Symbols

```assembly
define(name, value)            // Define a constant
```

### Code Scanning

```assembly
aobscan(name, bytes)           // Scan for byte pattern
aobscanmodule(name, module, bytes)  // Scan specific module
```

### Assertions

```assembly
assert(address, bytes)         // Verify bytes at address
```

---

## Assembly Basics

### Common Instructions

| Instruction | Purpose | Example |
|-------------|---------|---------|
| `mov` | Move/copy value | `mov eax,100` |
| `add` | Addition | `add eax,10` |
| `sub` | Subtraction | `sub eax,5` |
| `imul` | Multiply (signed) | `imul eax,2` |
| `idiv` | Divide (signed) | `idiv ebx` |
| `inc` | Increment by 1 | `inc eax` |
| `dec` | Decrement by 1 | `dec eax` |
| `cmp` | Compare | `cmp eax,100` |
| `jmp` | Jump unconditional | `jmp address` |
| `je` | Jump if equal | `je label` |
| `jne` | Jump if not equal | `jne label` |
| `jl` | Jump if less | `jl label` |
| `jg` | Jump if greater | `jg label` |
| `nop` | No operation | `nop` |

### Registers

**32-bit:**
- `eax`, `ebx`, `ecx`, `edx` - General purpose
- `esi`, `edi` - Index registers
- `ebp`, `esp` - Stack pointers

**64-bit:**
- `rax`, `rbx`, `rcx`, `rdx`, `rsi`, `rdi`, `rbp`, `rsp`
- `r8` through `r15`

**Float registers (SSE):**
- `xmm0` through `xmm15`

---

## Practical Examples

### Example 1: Infinite Ammo

**Find:** Code that decreases ammo
```assembly
sub [rbx+2C],1
```

**Inject:**
```assembly
[ENABLE]
"game.exe"+A1B2C3:
  nop
  nop

[DISABLE]
"game.exe"+A1B2C3:
  sub [rbx+2C],1
```

### Example 2: One-Hit Kill

**Find:** Code that subtracts enemy health
```assembly
sub [rax+10],ecx
```

**Inject:**
```assembly
[ENABLE]
alloc(newmem,128)

newmem:
  mov ecx,[rax+10]  // Set damage = current health
  sub [rax+10],ecx  // Kill instantly
  jmp returnhere

"game.exe"+12345:
  jmp newmem
returnhere:

[DISABLE]
dealloc(newmem)
"game.exe"+12345:
  sub [rax+10],ecx
```

### Example 3: Super Jump

**Find:** Code that sets jump height
```assembly
movss xmm0,[jumpHeight]
```

**Inject:**
```assembly
[ENABLE]
alloc(newmem,128)

newmem:
  movss xmm0,[superJump]
  jmp returnhere

superJump:
  dd (float)5.0  // 5x normal jump

"game.exe"+56789:
  jmp newmem
returnhere:

[DISABLE]
dealloc(newmem)
"game.exe"+56789:
  movss xmm0,[jumpHeight]
```

---

## Advanced Techniques

### Conditional Modifications

**Only affect player, not enemies:**

```assembly
newmem:
  cmp [rbx],#1      // Check if player (ID = 1)
  jne originalcode  // If not player, skip mod

  mov [rbx+10],#999 // Set player health to 999

originalcode:
  sub [rbx+10],eax
  jmp returnhere
```

### Symbol Definitions

**For readability:**

```assembly
define(health,[rbx+10])
define(maxHealth,#999)

newmem:
  mov health,maxHealth
  jmp returnhere
```

### Using Multiple Injections

**Combine multiple cheats:**

```assembly
[ENABLE]
// Injection 1: Infinite Health
"game.exe"+1111:
  mov [rax+10],#999

// Injection 2: Infinite Ammo
"game.exe"+2222:
  nop
  nop

// Injection 3: Super Speed
"game.exe"+3333:
  mulss xmm0,[speedHack]

speedHack:
  dd (float)2.0

[DISABLE]
// Restore all
"game.exe"+1111:
  sub [rax+10],ecx
"game.exe"+2222:
  sub [rbx+2C],1
"game.exe"+3333:
  movss xmm0,[normalSpeed]
```

---

## Debugging Your Scripts

### Testing

1. **Syntax Check:** Auto Assembler will highlight errors
2. **Execute:** Click "Execute" to test
3. **File > Assign to current cheat table:** Save to table

### Common Errors

**"This address specifies an address outside the range"**
- Address doesn't exist in current process
- Check if game is attached

**"Not all code is injectable"**
- Code is too short for jump
- Use AOB injection instead

**"There is not enough space"**
- Need more bytes for your jump
- Find different injection point

### Debugging Tools

1. **Memory Viewer:** See actual bytes
2. **Debugger:** Step through code
3. **Break and Trace:** Monitor execution

---

## Tips for Success

### ✅ Do:
- Start with templates
- Test each injection separately
- Keep backups of working scripts
- Comment your code
- Use meaningful label names

### ❌ Don't:
- Modify code you don't understand
- Forget to fill NOP spaces correctly
- Use too many injections (performance)
- Skip testing after each change

---

## Next Steps

1. **Practice with templates**
2. **Learn assembly language** (see resources below)
3. **Study existing cheat tables** (FearlessRevolution)
4. **Read CE Wiki** for advanced topics

---

## Resources

### CE Wiki Auto Assembler
- **Basics:** https://wiki.cheatengine.org/index.php?title=Tutorials:Auto_Assembler:Basics
- **Templates:** https://wiki.cheatengine.org/index.php?title=Tutorials:Auto_Assembler:Templates
- **Commands:** https://wiki.cheatengine.org/index.php?title=Auto_Assembler

### Assembly Learning
- **x86 Assembly:** https://en.wikibooks.org/wiki/X86_Assembly
- **ASM Basics (CE Wiki):** https://wiki.cheatengine.org/index.php?title=Help_File:Assembler
- **CE Forum Tutorials:** https://forum.cheatengine.org/viewforum.php?f=7

---

*Master Auto Assembler to create powerful, complex game modifications!*

*Based on CE Wiki - https://wiki.cheatengine.org*
