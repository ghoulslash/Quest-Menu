.text
.align 2
.thumb
.thumb_func
.global num_quests
/*
Store size of pc storage/quest menu. If the latter, set num quests total
	-could also dynamically load only quest names that you have unlocked

insert 00 00 00 48 00 47 xx xx xx 08 at 10ddae

testing 990d4c
*/
@.equ NumQuests, 30			@ should be possible to expand item storage size, since it uses a malloc

.include "src/headers/defs.asm"
num_quests:
	ldr r1, [r4]
	ldr r0, =QuestFlag
	ldrb r0, [r0]
	cmp r0, #0x0
	beq PCItemCount
	
FullSize:
	ldr r0, =NumQuests
	lsl r0, r0, #0x18
	lsr r0, r0, #0x18
	strb r0, [r1, #0x7]
	ldr r0, =(0x0810ddea +1)
	bx r0
	
PCItemCount:
	mov r0, #0x0
	strb r0, [r1, #0x7]
	mov r2, #0x0
	ldr r3, =(0x03005008)
	ldr r0, =(0x0810ddb6 +1)
	bx r0

@.align 2
@.QuestFlag:	.word 0x0203e061

