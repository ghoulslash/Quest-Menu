.text
.align 2
.thumb
.thumb_func
.global quest_status
/*
insert 00 48 00 47 xx xx xx 08 at 10da60

r4 is index



NOTES
	-'complete' runs off screen...possible to move back a bit?
			-x pos at 10da98
*/

.include "src/headers/defs.asm"

@.equ Offset, 0x0899010c

@.equ CompletedFlags, 0x2100

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
	beq CheckStatus			@no side quest active
	sub r1, #0x1
	cmp r1, r0
	bne CheckStatus

Active:
	ldr r1, =(active_str)
	b Decoder
	
CheckStatus:
	ldr r1, =(DoneFlags)  @ flag 2100 is first flag
	add r0, r0, r1			@ flag + index order
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10		@ completion flag for this quest
	bl CheckFlag			@ check flag
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
