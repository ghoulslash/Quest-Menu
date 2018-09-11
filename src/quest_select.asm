.text
.align 2
.thumb
.thumb_func
.global prevent_select
/*
remove 'select' ability to shift item order
*/

.include "src/headers/defs.asm"

prevent_select:
	ldr r0, =QuestFlag
	ldrb r0, [r0]
	cmp r0, #0x0
	bne SkipSelect
	
CheckSelect:
	mov r0, #0x4
	and r0, r1
	cmp r0, #0x0
	beq SkipSelect
	ldr r0, =(0x0810ded4 +1)
	bx r0
	
SkipSelect:
	ldr r0, =(0x0810df20 +1)
	bx r0
	
