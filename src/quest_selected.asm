.text
.align 2
.thumb
.thumb_func
.global selected_string
/*
-prevent bag_add_item, change message from 'withdrew fd 02' to something els

insert 00 48 00 47 xx xx xx 08 at 10e434


IDEAS:
	-buffer quest name and include in string
	
BUGS:
	-active/quit swapped	--> active quest is set in other routine before this one, so it will always be ending...
		-but need to set active in those funcs because it redraws quest active list
	
*/

@.equ Offset, 0x08xxxxxx
@.equ Offset, 0x8990240
.include "src/headers/defs.asm"

.include "src/headers/chars.asm"

selected_string:
	
	ldr r1, =QuestFlag
	ldrb r1, [r1]
	cmp r1, #0x0
	beq RegSel
	
QuestSel:
	ldrh r0, [r5, #0x2]		@ order index (0-indexed)
	
	@ buffer quest name?
	
	ldr r1, =(0x020370b8)
	strh r0, [r1]
	
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
	
Return:
	ldr r4, =(0x02021d18)
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
	
@.align 2
@.ActiveQuest:	.word 0x0203c014
@.QuestFlag:	.word 0x0203e061	
	
active_str:
.byte Q_, u_, e_, s_, t_, Space, A_, c_, t_, i_, v_, a_, t_, e_, d_, Dot, Dot, Dot, 0xff

end_str:
.byte Q_, u_, i_, t_, t_, i_, n_, g_, Dot, Dot, Dot, 0xff


