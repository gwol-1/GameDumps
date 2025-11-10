# Dragon Quest III HD-2D Remake - Cheat Engine Reference

This folder contains extracted game data tables useful for Cheat Engine research and modding.

## Key Data Files

### GOP_Item.json (1.05 MB)
**All in-game items with complete data**

**What's inside:**
- Item IDs (e.g., `ITEM_EQUIP_WEAPON_COPPER_SWORD`)
- Buy/Sell prices
- Attack/Defense values (`ParamValue`)
- Item types (Weapon, Armor, Consumable, etc.)
- Equipment restrictions
- Icon paths

**Cheat Engine Uses:**
- Find item IDs to spawn specific items
- Modify item prices in shops
- Change weapon/armor stats
- Identify cursed items (`IsCurse: true/false`)

**Example Entry:**
```json
"ITEM_EQUIP_WEAPON_COPPER_SWORD": {
  "SelfId": "ITEM_EQUIP_WEAPON_COPPER_SWORD",
  "BuyPrice": 180,
  "SellPrice": 72,
  "ParamValue": 10,  // Attack power
  "WeaponType": "EWeaponType::SWORD"
}
```

### GOP_Monster.json (708 KB)
**All enemy monsters with stats**

**What's inside:**
- Monster names and IDs
- HP, MP values
- Attack, Defense stats
- Gold drops
- Experience points
- Item drops
- Resistances

**Cheat Engine Uses:**
- Modify encounter rates
- Change monster stats for easier/harder battles
- Increase gold/EXP drops
- Force specific item drops

### GOP_Magic.json (1.47 MB)
**All spells and magic**

**What's inside:**
- Spell IDs and names
- MP costs
- Damage values
- Spell effects
- Target types (Single, All, etc.)
- Learning requirements

**Cheat Engine Uses:**
- Reduce MP costs
- Increase spell damage
- Unlock all spells
- Modify spell effects

### GOP_Shop.json (190 KB)
**Shop inventories**

**What's inside:**
- Shop IDs by location
- Item availability per shop
- Unlock conditions

**Cheat Engine Uses:**
- Unlock all shop items
- Force rare items to appear in shops

## Other Important Files

Located in: `../../../tools/unreal-engine-4/FModel/Output/Exports/Game/Content/Nicola/Data/DataTable/`

### Character/Party Data:
- **GOP_Job.json** - Character classes/jobs
- **GOP_LevelUpExp.json** - Experience tables for leveling
- **GOP_Job_AbilityLv.json** - Job abilities by level
- **GOP_Personality.json** - Personality system data

### Battle System:
- **GOP_Battle_Monster_Action.json** - Monster AI behaviors
- **GOP_Battle_Formation.json** - Enemy formations
- **GOP_Encounter_Monster.json** - Encounter data

### World/Map:
- **GOP_MapList.json** - All game maps
- **GOP_Event_[Location].json** - Event scripts per location
- **GOP_NPC_Talk_[Location].json** - NPC dialogue per location

### Text/Localization:
- **GOP_Text_Noun_ENGLISH.json** - English text for all items/monsters/spells

## How to Use with Cheat Engine

### Step 1: Identify What You Want to Modify
Example: You want to increase gold earned from battles

### Step 2: Find Relevant Data
1. Open **GOP_Monster.json**
2. Search for a specific monster
3. Find the `GoldDrop` or similar value
4. Note the monster ID

### Step 3: Use Cheat Engine
1. Attach CE to `DQIIIHD2DRemake.exe`
2. Search for the value (e.g., current gold amount)
3. Use the monster data to understand expected ranges
4. Modify memory addresses

### Step 4: Test and Document
- Test changes in-game
- Document working addresses in CE tables (.CT files)
- Save findings for later use

## Tips

### Finding Item IDs
Items follow naming patterns:
- Weapons: `ITEM_EQUIP_WEAPON_[NAME]`
- Armor: `ITEM_EQUIP_ARMOR_[NAME]`
- Consumables: `ITEM_TOOL_[NAME]`
- Key items: `ITEM_IMPORTANT_[NAME]`

### Understanding Values
- `BuyPrice` - Gold cost at shops
- `SellPrice` - Gold when selling (usually 40% of buy price)
- `ParamValue` - Main stat (Attack for weapons, Defense for armor)
- `IsCurse` - Cursed equipment flag

### Cross-Referencing
Use **GOP_Text_Noun_ENGLISH.json** to find English names:
- Search for item ID
- Get human-readable name
- Makes CE research easier

## Example: Finding Copper Sword ID

1. **In GOP_Item.json:**
   ```json
   "ITEM_EQUIP_WEAPON_COPPER_SWORD": {
     "SelfId": "ITEM_EQUIP_WEAPON_COPPER_SWORD",
     "BuyPrice": 180,
     "ParamValue": 10
   }
   ```

2. **In GOP_Text_Noun_ENGLISH.json:**
   ```json
   "Txt_Item_Name_Copper_Sword": "Copper sword"
   ```

3. **In Cheat Engine:**
   - Search inventory for Copper Sword
   - Look for value `180` (price) or `10` (attack)
   - Modify as needed

## Data Structure Notes

### Item Types (EItemType):
- `EQUIP_WEAPON` - Weapons
- `EQUIP_ARMOR` - Armor pieces
- `EQUIP_SHIELD` - Shields
- `EQUIP_HELMET` - Headgear
- `TOOL` - Consumable items
- `IMPORTANT` - Key items

### Weapon Types (EWeaponType):
- `SWORD` - Swords
- `AXE` - Axes
- `SPEAR` - Spears/Lances
- `BOOMERANG` - Boomerangs
- `WHIP` - Whips
- etc.

## Safety Notes

⚠️ **Backup Your Saves Before Using CE**

- CE can corrupt save files if used incorrectly
- Always keep backup saves
- Test on separate save files first

⚠️ **Single Player Only**

- Only use CE in single-player mode
- Never use cheats in online/multiplayer features

⚠️ **Game May Patch**

- Updates can change memory addresses
- Data structures may change with patches
- Re-extract data after major updates

## Next Steps

1. **Explore the JSON files** - Open them in a text editor or JSON viewer
2. **Document findings** - Note useful IDs and values
3. **Create CE tables** - Save working addresses in .CT files
4. **Share knowledge** - Document discoveries for the community

## Additional Resources

- [Cheat Engine Official Site](https://www.cheatengine.org/)
- [Cheat Engine Forums](https://fearlessrevolution.com/)
- FModel for re-extracting after updates

---

*Data extracted: 2025-11-10*
*Game Version: 1.2.1*
*All data for research and educational purposes only*
