.text
.align 2
.thumb
.thumb_func
.global selected_string
/*
prevent bag_add_item, change message from 'withdrew fd 02' to something els
*/

.include "src/headers/defs.asm"
.include "src/headers/chars.asm"

selected_string:	
	ldr r1, =QuestFlag
	ldrb r1, [r1]
	cmp r1, #0x0
	beq RegSel
	
QuestSel:
	ldrh r0, [r5, #0x2]		@ order index (0-indexed)
	ldr r1, =(0x0203ade6)
	ldrb r1, [r1]			@ selected option
	cmp r1, #0x1			@ details
	beq GetDetail
	add r0, #0x1		@ 1-indexed order
	ldr r4, =ActiveQuest
	ldrh r1, [r4]		@ active quest (1-indexed)
	cmp r1, r0
	bne EndQuest	@swapped from beq b/c active quest already stored at this point, so opposite
	
StartQuest:
	ldr r1, =(active_str)
	b Return
	
EndQuest:
	ldr r1, =(end_str)
	b Return
	
GetDetail:
	push {r4}
	mov r4, r0
	lsl r0, r0, #0x2
	ldr r1, =(deet_table)
	add r0, r0, r1
	ldr r1, [r0]
	mov r0, r4
	pop {r4}
	
Return:
	ldr r4, =DisplayedString
	ldr r0, =(0x0810e46a +1)
	bx r0
	
RegSel:
	ldrh r1, [r5, #0x10]	@num PC item
	mov r0, r4
	bl BagAddItem
	ldr r1, =(0x0810e43c +1)
	bx r1
		
BagAddItem:
	ldr r2, =(0x0809a084 +1)
	bx r2
	
active_str:
.byte Q_, u_, e_, s_, t_, Space, A_, c_, t_, i_, v_, a_, t_, e_, d_, Dot, Dot, Dot, 0xff

end_str:
.byte D_, e_, a_, c_, t_, i_, v_, a_, t_, i_, n_, g_, Dot, Dot, Dot, 0xff

.pool
.align 2
deet_table:
.word deet_1
.word deet_2
.word deet_3
.word deet_4
.word deet_5

deet_1:	.byte D_, u_, d_, e_, 0xff
deet_2:	.byte P_, e_, r_, s_, o_, n_, _2_, 0xff
deet_3:	.byte P_, e_, r_, s_, o_, n_, _3_, 0xff
deet_4:	.byte P_, e_, r_, s_, o_, n_, _4_, 0xff
deet_5:	.byte P_, e_, r_, s_, o_, n_, _5_, 0xff
