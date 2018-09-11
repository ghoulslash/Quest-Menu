.text
.align 2
.thumb
.thumb_func
.global quest_names
/*
show quest names instead of item names
*/

.include "src/headers/chars.asm"
.include "src/headers/defs.asm"

quest_names:
	push {r5-r7}
	mov r4, #0x0		@ loop counter
	ldr r0, =QuestFlag
	ldrb r0, [r0]
	ldr r6, =(QuestNames)
	mov r7, #0x1
	cmp r0, #0x0
	bne NameLoop
	
LoadPCItem:
	ldr r0, =(0x03005008)
	ldr r0, [r0]
	ldr r1, =(0x00000298)
	add r6, r0, r1		@ start of pc item data
	mov r7, #0x0
	
NameLoop:
	cmp r7, #0x0
	bne LoadQuestName
	
LoadItemName:
	lsl r1, r4, #0x2	@4*loop index
	mov r0, r6			@area to load from
	add r0, r0, r1
	ldrh r0, [r0]
	bl PCItemName
	b SetPointer
	
LoadQuestName:
	ldr r0, =(ActivatedFlags)	@ initiation flags
	add r0, r0, r4			@ loop index + init_flag
	bl CheckFlag
	cmp r0, #0x0
	beq UnkownQuest

KnownQuest:
	mov r0, r6
	lsl r1, r4, #0x2	@4*loop index
	add r0, r0, r1
	ldr r0, [r0]		@ ptr to quest name
	b SetPointer
	
UnkownQuest:
	ldr r0, =(q_null)
	
SetPointer:
	ldr r1, =(0x0203adc4)	@pcitem_list pointer
	ldr r1, [r1]			@pcitems
	lsl r2, r4, #0x3		@8*index
	add r1, r1, r2
	str r0, [r1]			@store string pointer
	str r4, [r1, #0x4]		@store list order number
	
NextItem:	
	add r0, r4, #0x1	@increase loop index
	lsl r0, r0, #0x10
	lsr r4, r0, #0x10
	ldr r0, =(0x0203adbc)
	ldr r0, [r0]
	ldrb r0, [r0, #0x7]		@num items to store
	cmp r4, r0
	bcc NameLoop
	
ReturnAddCancel:
	pop {r5-r7}
	ldr r0, =(0x0810d8ae +1)
	bx r0
	
CheckFlag:
	ldr r1, =(0x0806e6d0 +1)
	bx r1

PCItemName:
	ldr r1, =(0x0809a8bc +1)
	bx r1

.align 2
QuestNames:
.word q1
.word q2
.word q3
.word q4
.word q5
	
q1:
.byte Q_, u_, e_, s_, t_, _1_, 0xff

q2:
.byte L_, a_, i_, d_, Space, T_, o_, Space, R_, e_, s_, t_, 0xff

q3:
.byte Q_, u_, e_, s_, t_, _3_, 0xff

q4:
.byte Q_, u_, e_, s_, t_, _4_, 0xff

q5:
.byte F_, o_, r_, b_, i_, d_, d_, e_, n_, Space, R_, i_, t_, u_, a_, l_, 0xff

q_null:
.hword Color
.byte C_grey, QMark, QMark, QMark, QMark, QMark, QMark, QMark, QMark, 0xff
