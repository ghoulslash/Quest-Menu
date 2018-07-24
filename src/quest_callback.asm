.text
.align 2
.thumb
.thumb_func
.global quest_callback
/*
set callback to start menu from quest menu

insert 00 48 00 47 xx xx xx 08 at ebcf8

*/

@.equ Offset, 0x89908d0

.include "src/headers/defs.asm"

quest_callback:
	push {r4}
	ldrb r0, [r5, #0xc]
	
	ldr r1, =QuestFlag
	ldrb r1, [r1]
	cmp r1, #0x0
	bne QuestCallback
	
RegCallback:
	ldr r1, =(0x080567dc +1)	@c2_exit_to_overworld_2_switch
	b ReturnCB
	
QuestCallback:
	ldr r1, =callback_func+1	@start menu callback
	
ReturnCB:
	bl setcallback
	pop {r4}
	ldr r0, =(0x080ebd00 +1)
	bx r0	
	
setcallback:
	ldr r4, =(0x0810d3f4 +1)
	bx r4

.align 2	
callback_func:
	push {lr}
	ldr r0, =QuestFlag
	mov r1, #0x0
	strb r1, [r0]		@ reset quest menu
	ldr r0, =(0x080568a8 +1)
	bl setcallback2
	pop {r0}
	bx r0
	
setcallback2:
	ldr r1, =(0x08000544 +1)
	bx r1
	
@.align 2
@.QuestFlag:	.word 0x0203e061
