/*=====QUEST=MENU=PUBLIC======*/
1. Public source code for side quest menu hack

/*=====FEATURES=====*/
1. Hacks the PC Item Storage to show side quests instead of pc items.
2. Quests that have yet to be 'unlocked' show up as '??????'
3. Quest Description includes an item image chosen by the developer (see src/description.asm)
4. Allows player to keep track of active and completed quests
5. Includes a short description and potential for further details if the player forgets what their current quest is

/*=====COMPILATION=====*/
1. Install GNU make and DevkitARM (see pokecommunity forums for further detail)
2. Place a bpre0.gba in the extracted folder
3. Edit insertion address at bottom of insert.s
4. Edit all custom RAM definitions in src/headers/defs.asm
5. Open command prompt at this directory and type 'make'
