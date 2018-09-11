.text
.align 2
.thumb
.thumb_func
.global quest_opt_strings
/*
change the strings loaded in the multichoice when selecting an item in the quest menu
*/

.include "src/headers/defs.asm"
.include "src/headers/chars.asm"

quest_opt_strings:
	mov r5, #0x3	@number of options
	str r5, [sp, #0x4]
	ldr r0, =QuestFlag
	ldrb r0, [r0]
	cmp r0, #0x0
	bne QuestOptStrs
	
RegOptStrs:
	ldr r0, =(0x08453f74)	@item storage strings/funcs
	b Return
	
QuestOptStrs:
	ldrh r1, [r6, #0x2]		@ selected quest index
	ldr r0, =var8007
	strh r1, [r0]		@ store selected quest index into var8007

QuestOpts:
	ldr r0, =ActiveQuest
	ldrh r0, [r0]		@ current quest, 1-indexed (eg. index 0 = quest 1)
	cmp r0, #0x0
	beq Activate
	add r1, #0x1		@ quest index is 1-indexed
	cmp r0, r1
	beq Deactivate

Activate:	
	ldr r0, =Start_Opts
	b Return
	
Deactivate:
	ldr r0, =Stop_Opts
	
Return:
	str r0, [sp, #0x8]
	ldr r0, =(0x0810e2bc +1)
	bx r0

.align 2
Start_Opts:
.word start_str
.word 0
.word details_str
.word 0
.word 0x084161c1	@cancel
.word 0

.align 2
Stop_Opts:
.word stop_str
.word 0
.word details_str
.word 0
.word 0x084161c1	@cancel
.word 0

start_str:
.byte B_, e_, g_, i_, n_, 0xff

stop_str:
.byte E_, n_, d_, 0xff

details_str:
.byte D_, e_, t_, a_, i_, l_, s_, 0xff
	