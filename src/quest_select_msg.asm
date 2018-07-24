.text
.align 2
.thumb
.thumb_func
.global selected_msg
/*
1. alter message that is displayed when an entry is sel_ected in the quest menu

insert 00 48 00 47 xx xx xx 08 at 10e2ec

*/

.include "src/headers/chars.asm"

.include "src/headers/defs.asm"

@.equ Offset, 0x89912fc

selected_msg:
	ldrh r0, [r6, #0x2]

	ldr r1, =QuestFlag
	ldrb r1, [r1]
	cmp r1, #0x0
	beq Itemsel
	
Questsel:
	ldr r1, =(sel_str)
	ldr r6, =(0x02021d18)
	mov r0, r6
	b ReturnDecoder
	
Itemsel:	
	bl GetItemID	
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	ldr r1, =(0x0810e2f4 +1)
	bx r1
	
ReturnDecoder:	
	ldr r2, =(0x0810e300 +1)
	bx r2
	
GetItemID:
	ldr r1, =(0x0810dd68 +1)
	bx r1
	
@.align 2
@.QuestFlag:	.word 0x0203e061

sel_str:
.byte W_, h_, a_, t_, Space, W_, o_, u_, l_, d_, Space, Y_, o_, u_, NewLine, L_, i_, k_, e_, Space, T_, o_, Space, D_, o_, QMark, 0xff

