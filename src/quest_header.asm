.text
.align 2
.thumb
.thumb_func
.global header_box
/*
make top left box say "Quests" instead of "Withdraw Item"
*/

.include "src/headers/chars.asm"
.include "src/headers/defs.asm"

header_box:
	ldr r1, =QuestFlag
	ldrb r1, [r1]
	cmp r1, #0x0
	beq WithdrawStr

QuestHeader:
	ldr r2, =(header_string)
	b HeaderReturn
	
WithdrawStr:
	ldr r2, =(0x084178a7)
		
HeaderReturn:	
	mov r1, #0x1
	str r1, [sp]
	mov r0, #0x0
	str r0, [sp, #0x4]
	ldr r3, =(0x0810db42 +1)
	bx r3	

header_string:
.byte Space, Q_, u_, e_, s_, t_, s_, 0xff

