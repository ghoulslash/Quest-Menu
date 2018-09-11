.text
.align 2
.thumb
.thumb_func
.global quest_status
/*

*/

.include "src/headers/defs.asm"
.include "src/headers/chars.asm"

quest_status:
	mov r0, r4
	ldr r1, =QuestFlag
	ldrb r1, [r1]
	cmp r1, #0x0
	bne CheckActive
	
ItemCount:
	bl CountPCItems
	ldr r1, =(0x0810da68 +1)
	bx r1
	
CountPCItems:
	ldr r1, =(0x0810dd80 +1)
	bx r1
	
CheckActive:
	ldr r1, =ActiveQuest
	ldrh r1, [r1]
	cmp r1, #0x0
	beq CheckStatus
	sub r1, #0x1
	cmp r1, r0
	bne CheckStatus

Active:
	ldr r1, =(active_str)
	b Decoder
	
CheckStatus:
	ldr r1, =(CompletedFlags)
	add r0, r0, r1
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	bl CheckFlag
	cmp r0, #0x0
	beq Null
	
Complete:
	ldr r1, =(complete_str)
	b Decoder
	
Null:
	ldr r1, =(null_str)
	
Decoder:	
	ldr r4, =DisplayedString
	mov r0, r4
	bl fdecoder
	
Return:
	ldr r0, =(0x0810da82 +1)
	bx r0
		
fdecoder:
	ldr r2, =(0x08008fcc +1)
	bx r2
	
CheckFlag:
	ldr r1, =check_flag+1
	bx r1
	
active_str:
.hword Color
.byte C_dark_blue, A_, c_, t_, i_, v_, e_, 0xff

complete_str:
.hword Color
.byte C_dark_green, Space, D_, o_, n_, e_, 0xff

null_str:
.byte 0xff
