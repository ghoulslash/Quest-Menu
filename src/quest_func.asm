.text
.align 2
.thumb
.thumb_func
.global open_menu
/*
open pc box automatically without multichoice boxes
testing 990320

need to set callback separately 0x080568a8
*/

.include "src/headers/defs.asm"

quest_func:
	push {r4-r6, lr}
	
	ldr r1, =QuestFlag
	mov r0, #0x1
	strb r0, [r1]	@ set quest flag on
	
	mov r0, #0x0	@ task number
	bl CreateMenu
	
	pop {r4-r6, pc}
	
CreateMenu:
	ldr r1, =(0x080ebcd8 +1)
	bx r1
