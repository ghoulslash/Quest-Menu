.text
.align 2
.thumb
.thumb_func
.global quest_opt_funcs
/*
change the function loaded when selecting item in quest menu
*/

.include "src/headers/defs.asm"
.include "src/headers/chars.asm"

quest_opt_funcs:
	mov r0, #0x5
	bl AudioPlay
	ldr r0, =QuestFlag
	ldrb r0, [r0]
	cmp r0, #0x0
	bne QuestOptFuncs
	
RegOptFuncs:
	ldr r0, =(0x08453f74)	@item storage opts
	b ReturnOptFunc
	
QuestOptFuncs:
	ldr r0, =var8007
	ldrh r0, [r0]		@ selected item index
	ldr r1, =ActiveQuest
	ldrh r1, [r1]
	cmp r1, #0x0
	beq ActiveTable
	add r0, #0x1		@ 1-indexed
	cmp r0, r1
	beq DeactiveTable
	
ActiveTable:
	ldr r0, =Start_Opts
	b ReturnOptFunc

DeactiveTable:
	ldr r0, =Stop_Opts

ReturnOptFunc:
	lsl r1, r4, #0x3
	add r0, #0x4
	add r1, r1, r0
	ldr r1, [r1]		@ function to play
	ldr r0, =(0x0810e394 +1)
	bx r0
	
AudioPlay:
	ldr r1, =(0x080722cc +1)
	bx r1
	
.align 2
Start_Opts:
.word 0
.word start_func+1
.word 0
.word deet_func+1
.word 0
.word 0x0810e8a0+1

.align 2
Stop_Opts:
.word 0
.word stop_func+1
.word 0
.word deet_func+1
.word 0
.word 0x0810e8a0+1

.align 2
start_func:
	push {r4-r7, lr}
	mov r5, r0
	ldr r4, =ActiveQuest
	ldr r1, =var8007
	ldrh r1, [r1]
	add r1, #0x1
	strh r1, [r4]
	b EndFunc
	
.align 2
deet_func:
	push {r4-r7, lr}
	b EndFunc
	
.align 2
stop_func:
	push {r4-r7, lr}
	ldr r4, =ActiveQuest
	mov r1, #0x0
	strh r1, [r4]

EndFunc:
	bl CancelBox
	mov r0, #10		@ up arrow
	bl DeleteObj
	mov r0, #11		@ down arrow
	bl DeleteObj
	mov r0, r5
	bl Refresh
	pop {r4-r7}
	pop {r0}
	bx r0
	
CancelBox:
	ldr r4, =(0x0810e8a0 +1)
	bx r4

Refresh:
	ldr r4, =(0x0810e418 +1)
	bx r4
	
DeleteObj:
	push {lr}
	mov r1, #68
	mul r0, r1
	ldr r1, =(0x0202063c)
	add r0, r0, r1
	bl Delete
	pop {pc}
	
Delete:
	ldr r4, =(0x08076030 +1)
	bx r4
