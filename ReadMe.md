QUEST MENU PUBLIC SOURCE CODE
1. Public source code for side quest menu hack
2. This system is an organization tool for the player to track their side quests or tasks throughout the game.

Features:
1. Hacks the PC Item Storage to show side quests instead of pc items.
2. Quests that have yet to be 'unlocked' show up as '??????'
3. Quest Description includes an item image chosen by the developer (see src/description.asm)
4. Allows player to keep track of active and completed quests
5. Includes a short description and potential for further details if the player forgets what their current quest is

Compilation:
1. Install GNU make and DevkitARM (see pokecommunity forums for further detail)
2. Place a bpre0.gba in the extracted folder
3. Edit insertion address at bottom of insert.s
4. Edit all custom RAM definitions in src/headers/defs.asm
4a. The activation flags cause the quest name to appear in the menu. You need <NumQuests> number of activation flags in succession starting at flag 0x"ActiveFlags", and <NumQuests> completion flags in succession, starting from "CompletionFlags"
5. Make table of quest names at bottom of src/quest_names.asm
6. Make table of quest descriptions/item IDs in src/quest_descriptions.asm
7. Make table of quest details in src/quest_selected.asm
8. Open command prompt at this directory and type 'make'

How to Use:
1. In a script (XSE):
	writebytetooffset 0x1 [QUESTFLAG_RAM]   // set the hack ram flag
	
	fadescreen 0x1
	
	callasm 0x80EBCD9       // open the menu
	
	waitstate
	
2. No need to reset the flag, the callback function takes care of this.

