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
	neg r0, r0		@fe ff ff ff -> cancel
	cmp r4, r0
	beq CancelDescript

CheckQuestMenu:
	ldr r0, =QuestFlag
	ldrb r0, [r0]
	cmp r0, #0x0
	beq RegMenu

QuestMenu:
	mov r0, r4				@ cursor index
	ldr r1, =(ActivatedFlags)	@first flag for showing quest names
	add r0, r0, r1		@ flag for quest where cursor is
	bl CheckFlag
	cmp r0, #0x0
	bne GetQuestDifficulty
	bl qmark_img			@ quest not unlocked, show ? image
	b UnknownDescript
	
GetQuestDifficulty:
	mov r0, r4		@ cursor index
	lsl r0, r0, #0x2
	ldr r1, =(ImageIDs)
	add r0, r0, r1
	ldrh r0, [r0]
	ldr r1, [r5]
	ldrb r1, [r1, #0x5]
	bl CreateImage	

GetQuestDescription:
	mov r0, r4		@ cursor index
	lsl r0, r0, #0x2
	ldr r1, =(QuestDescripts)
	add r0, r0, r1
	ldr r0, [r0]		@ quest description for selected quest
	b ReturnDesc

UnknownDescript:
	ldr r0, =(descript_unk)
	b ReturnDesc	
	
CancelDescript:
	bl qmark_img
	ldr r0, =(descript_cancel)
	
ReturnDesc:
	mov r5, r0
	ldr r0, =(0x0810d9da +1)
	bx r0
	
RegMenu:
	ldr r0, =(0x0810d984 +1)
	bx r0

qmark_img:
	push {lr}
	ldr r0, =(0x00000177)
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
.hword ITEM_POKEBALL
.hword ITEM_GREATBALL
.hword ITEM_ULTRABALL
.hword ITEM_MASTERBALL
.hword ITEM_MASTERBALL

.align 2
QuestDescripts:
.word descript_q1
.word descript_q2
.word descript_q3
.word descript_q4
.word descript_q5

descript_q1:
.byte D_, o_, Space, A_, Space, T_, h_, i_, n_, g_, 0xff

descript_q2:
.byte C_, a_, p_, t_, u_, r_, e_, Space, A_, Space, D_, u_, s_, k_, u_, l_, l_, Space, A_, n_, d_, Space, S_, h_, o_, w_, Space, I_, t_, Space, T_, o_, NewLine, T_, h_, e_, Space, T_, h_, e_, Space, C_, e_, m_, e_, t_, e_, r_, y_, Space, O_, w_, n_, e_, r_, 0xff

descript_q3:
.byte D_, e_, f_, e_, a_, t_, Space, S_, o_, m_, e_, o_, n_, e_, 0xff

descript_q4:
.byte t_, e_, s_, t_, 0xff

descript_q5:
.byte S_, u_, m_, m_, o_, n_, Space, A_, Space, F_, o_, r_, b_, i_, d_, d_, e_, n_, Space, P_, o_, k_, e_acute_, m_, o_, n_, NewLine, A_, t_, Space, T_, h_, e_, Space, C_, h_, u_, r_, c_, h_, 0xff

descript_cancel:
.byte E_, x_, i_, t_, 0xff

descript_unk:
.byte A_, 0xff
