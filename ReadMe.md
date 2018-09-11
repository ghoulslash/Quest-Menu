/*=====QUEST=MENU=PUBLIC======*/
1. Public source code for side quest menu hack

/*=====FEATURES=====*/
1. Hacks the PC Item Storage to show side quests instead of pc items.
2. Quests that have yet to be 'unlocked' show up as '??????'
3. Quest Description includes an item image chosen by the developer (see src/description.asm)
4. Allows player to keep track of active and completed quests
5. Includes a short description and potential for further details if the player forgets what their current quest is

<<<<<<< HEAD
;=========================How to Compile?==========================;
1. To compile this project, you need to install GNU make and DevkitARM, 
and place a bpre0.gba in the extracted folder, and then perform a double 
click on compile.bat/compile.sh. OR open folder in windows command prompt
and type 'make', if you have the make.exe inside.
2. A binary of armips (32-bit) v0.8 has been added to this repo. 

;=========================How to Use?==============================;
1. The free space offset is provided in the 108th line of the file insert.s.
	You must edit it in order to compile.
2. Alter the free RAM, number of quests, and other parameters in src/headers/defs.asm 
3. use callasm 0x080ebcd8+1 to load menu
=======
/*=====COMPILATION=====*/
1. Install GNU make and DevkitARM (see pokecommunity forums for further detail)
2. Place a bpre0.gba in the extracted folder
3. Edit insertion address at bottom of insert.s
4. Edit all custom RAM definitions in src/headers/defs.asm
5. Open command prompt at this directory and type 'make'
>>>>>>> dc3a24f00d5ac506c395ac94487b0ff4ce5c97b8
