.text
.align 2
.thumb
.thumb_func
.global quest_callback
/*
set callback to start menu from quest menu
*/

.include "src/headers/defs.asm"

quest_callback:
	push {r4}
	ldr r1, =QuestFlag
	ldrb r0, [r1]
	cmp r0, #0x0
	beq SetCallback
	mov r0, #0x0
	strb r0, [r1]	@ reset quest flag
	
SetCallback:
	ldrb r0, [r5, #0xc]
	ldr r1, =(0x080567dc +1)
	bl setcallback
	pop {r4}
	ldr r0, =(0x080ebd00 +1)
	bx r0	
	
setcallback:
	ldr r4, =(0x0810d3f4 +1)
	bx r4
	