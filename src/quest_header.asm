.text
.align 2
.thumb
.thumb_func
.global header_box
/*
make box say "Side Quests" instead of "Withdraw Item"


insert 00 48 00 47 xx xx xx 08 at 10db38
*/

.include "src/headers/chars.asm"
.include "src/headers/defs.asm"

@.equ Offset, 0x8990cc0

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

@.align 2
@.QuestFlag:	.word 0x0203e061
	
header_string:
.hword Color
.byte C_light_green, Space, Space, S_, i_, d_, e_, NewLine, Space, Q_, u_, e_, s_, t_, s_, 0xff

