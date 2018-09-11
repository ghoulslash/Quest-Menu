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
	mov r4, #0x0
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
	add r6, r0, r1
	mov r7, #0x0
	
NameLoop:
	cmp r7, #0x0
	bne LoadQuestName
	
LoadItemName:
	lsl r1, r4, #0x2
	mov r0, r6
	add r0, r0, r1
	ldrh r0, [r0]
	bl PCItemName
	b SetPointer
	
LoadQuestName:
	ldr r0, =(ActivatedFlags)
	add r0, r0, r4
	bl CheckFlag
	cmp r0, #0x0
	beq UnkownQuest

KnownQuest:
	mov r0, r6
	lsl r1, r4, #0x2
	add r0, r0, r1
	ldr r0, [r0]
	b SetPointer
	
UnkownQuest:
	ldr r0, =(q_null)
	
SetPointer:
	ldr r1, =(0x0203adc4)
	ldr r1, [r1]
	lsl r2, r4, #0x3
	add r1, r1, r2
	str r0, [r1]
	str r4, [r1, #0x4]
	
NextItem:	
	add r0, r4, #0x1
	lsl r0, r0, #0x10
	lsr r4, r0, #0x10
	ldr r0, =(0x0203adbc)
	ldr r0, [r0]
	ldrb r0, [r0, #0x7]
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
.word <first quest name pointer>
@etc...
.word <last quest name pointer>

q_null:
.hword Color
.byte C_grey, QMark, QMark, QMark, QMark, QMark, QMark, QMark, QMark, 0xff
