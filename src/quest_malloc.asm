.text
.align 2
.thumb
.thumb_func
.global quest_malloc
/*
memory allocation for quest menu
*/

.include "src/headers/defs.asm"

quest_malloc:
	ldr r0, =QuestFlag
	ldrb r0, [r0]
	cmp r0, #0x0
	beq Item_malloc
	
Quest_malloc:
	ldr r0, =( (NumQuests+1) * 8)
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	b Finish
	
Item_malloc:
	mov r0, #(31*8)
	
Finish:
	bl MemAlloc
	str r0, [r4]
	cmp r0, #0x0
	beq FreeUp
	ldr r4, =(0x0810d84c +1)
	bx r4
	
FreeUp:
	ldr r0, =(0x0810d868 +1)
	bx r0

MemAlloc:
	ldr r1, =(0x08002b9c +1)
	bx r1
