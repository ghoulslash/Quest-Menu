;==========================QUEST MENU==============================;

;==========================Introduction============================;
1. Public source code for side quest menu hack.
2. Hacks the PC Item Storage to load side quests instead of items.
3. Allows user to select quest to 'activate' and displays active and completed quests.

;=========================How to Compile?==========================;
1. To compile this project, you need to install GNU make and DevkitARM, 
and place a bpre0.gba in the extracted folder, and then perform a double 
click on compile.bat/compile.sh. OR open folder in windows command prompt
and type 'make', if you have the make.exe inside.
2. A binary of armips (32-bit) v0.8 has been added to this repo. 

;=========================How to Config?===========================;
1. The free space offset is provided in the 108th line of the file insert.s.
	You must edit it in order to compile.
2. Alter the free RAM, number of quests, and other parameters in src/headers/defs.asm 
