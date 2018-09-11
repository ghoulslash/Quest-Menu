.text
.align 2
.thumb
.thumb_func
.global prevent_a
/*
do nothing when 'a' is pressed for unknown or finished quest
*/

.include "src/headers/defs.asm"

prevent_a:
	push {r4-r5}
	mov r4, r2			@ super struct
	mov r5, r3			@ task struct
	ldr r0, =QuestFlag
	ldrb r0, [r0]
	cmp r0, #0x0
	bne CheckKnown
	push {r1-r3}
	b CheckA

CheckKnown:
	push {r1-r3}
	bl GetItemPos	@ get item pos in r0
	mov r1, #0x2
	neg r1, r1
	cmp r1, r0
	beq CheckA
	ldr r1, =(ActivatedFlags)
	add r0, r0, r1
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	bl CheckFlag
	cmp r0, #0x0
	beq SkipACheck		@flag not set, quest unkown -> can't press A
	
CheckDone:
	mov r3, r5
	bl GetItemPos
	ldr r1, =(CompletedFlags)
	add r0, r0, r1
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	bl CheckFlag
	cmp r0, #0x0
	bne SkipACheck		@flag set -> quest complete -> can't press A
	
CheckA:
	mov r2, r4		@ super struct
	ldrh r1, [r2, #0x2e]	@ button pressed
	mov r0, #0x1
	and r0, r1
	cmp r0, #0x0
	beq SkipACheck
	pop {r1-r3}	
	mov r3, r5
	mov r2, r4
	ldrh r1, [r2, #0x2e]	@ button pressed
	pop {r4-r5}
	ldr r0, =(0x08107094 +1)
	bx r0
	
SkipACheck:
	pop {r1-r3}
	mov r2, r4
	ldrh r1, [r2, #0x2e]	@ button pressed
	mov r3, r5
	pop {r4-r5}
	ldr r0, =(0x081070ac +1)
	bx r0
	
CheckFlag:
	ldr r1, =(0x0806e6d0 +1)
	bx r1
	
GetItemPos:
	push {lr}
	ldrh r0, [r3, #0x18]
	ldrh r1, [r3, #0x1a]
	add r0, r0, r1
	ldr r1, [r3]
	lsl r0, r0, #0x3
	add r0, r0, r1
	ldr r0, [r0, #0x4]
	pop {pc}
	