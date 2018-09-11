.text
.align 2
.thumb
.thumb_func
.global quest_descriptions

.include "src/headers/defs.asm"
.include "src/headers/chars.asm"
.include "src/headers/items.asm"

quest_descriptions:
	mov r0, #0x2
	neg r0, r0
	cmp r4, r0
	beq CancelDescript

CheckQuestMenu:
	ldr r0, =QuestFlag
	ldrb r0, [r0]
	cmp r0, #0x0
	beq RegMenu

QuestMenu:
	mov r0, r4
	ldr r1, =(ActivatedFlags)
	add r0, r0, r1
	bl CheckFlag
	cmp r0, #0x0
	bne GetImage
	mov r0, #0x0
	bl other_img
	b UnknownDescript
	
GetImage:
	mov r0, r4
	lsl r0, r0, #0x1
	ldr r1, =(ImageIDs)
	add r0, r0, r1
	ldrh r0, [r0]
	ldr r1, [r5]
	ldrb r1, [r1, #0x5]
	bl CreateImage	

GetQuestDescription:
	mov r0, r4
	lsl r0, r0, #0x2
	ldr r1, =(QuestDescripts)
	add r0, r0, r1
	ldr r0, [r0]
	b ReturnDesc

UnknownDescript:
	ldr r0, =(descript_unk)
	b ReturnDesc	
	
CancelDescript:
	ldr r0, =(0x177)
	bl other_img
	ldr r0, =(descript_cancel)
	
ReturnDesc:
	mov r5, r0
	ldr r0, =(0x0810d9da +1)
	bx r0
	
RegMenu:
	ldr r0, =(0x0810d984 +1)
	bx r0

other_img:
	push {lr}
	ldr r1, [r5]
	ldrb r1, [r1, #0x5]
	bl CreateImage
	pop {pc}
	
CreateImage:
	ldr r2, =(0x080988e8 +1)
	bx r2

CheckFlag:
	ldr r1, =(0x0806e6d0 +1)
	bx r1	

.pool	
.align 2
ImageIDs:
.hword <first quest image ID>
@etc...
.hword <last quest image ID>

.align 2
QuestDescripts:
.word <first quest description pointer>
@etc...
.word <first quest description pointer>

descript_cancel:
.byte E_, x_, i_, t_, 0xff

descript_unk:
.byte U_, n_, k_, n_, o_, w_, n_, 0xff
