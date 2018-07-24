.text
.align 2
.thumb
.thumb_func
.global quest_descriptions
/*
1. skip over item image creation/deletion
2. change description box to have quest descriptions

insert 00 48 00 47 xx xx xx 08 at 10d974

*/

.include "src/headers/defs.asm"
@.equ InitiateFlags, 0x2200		@start of flags that indicate quest is available (in order)

@.equ Offset, 0x08991e40

.include "src/headers/chars.asm"

quest_descriptions:
	ldr r0, =QuestFlag
	ldrb r0, [r0]
	cmp r0, #0x0
	bne QuestMenuDescript
	
RegDescripts:
	mov r0, #0x1
	eor r0, r1
	bl DeleteItemObj
	ldr r0, =(0x0810d97c +1)
	bx r0
	
DeleteItemObj:
	ldr r1, =(0x08098940 +1)
	bx r1
	
QuestMenuDescript:
	mov r0, r4		@ index of cursor
	mov r1, #0x2
	neg r1, r1		@ fe ff ff ff -> cancel index
	cmp r1, r0
	beq CancelDescript
	
	ldr r1, =(StartFlags)	@first flag for showing quest names
	add r0, r0, r1		@ flag for quest where cursor is
	bl CheckFlag
	cmp r0, #0x0
	beq UnknownDescript
	
KnownQuest:	
	mov r0, r4
	lsl r0, r0, #0x2
	ldr r1, =(QuestDescripts)
	add r0, r0, r1
	ldr r0, [r0]		@ quest description for selected quest
	b ReturnDesc
	
UnknownDescript:
	ldr r0, =(descript_unk)
	b ReturnDesc
	
CancelDescript:
	ldr r0, =(descript_cancel)
	
ReturnDesc:
	mov r5, r0
	ldr r0, =(0x0810d9da +1)
	bx r0
	
CheckFlag:
	ldr r1, =(0x0806e6d0 +1)
	bx r1
	
@.align 2
@.QuestFlag:	.word 0x0203e061
	
QuestDescripts:
.word descript_q1
.word descript_q2
.word descript_q3
.word descript_q4
.word descript_q5
.word descript_q6
.word descript_q7
.word descript_q8
.word descript_q9
.word descript_q10
.word descript_q11
.word descript_q12
.word descript_q13
.word descript_q14
.word descript_q15
.word descript_q16
.word descript_q17
.word descript_q18
.word descript_q19
.word descript_q20
.word descript_q21
.word descript_q22
.word descript_q23
.word descript_q24
.word descript_q25
.word descript_q26
.word descript_q27
.word descript_q28
.word descript_q29
.word descript_q30

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

descript_q6:
.byte S_, t_, u_, f_, f_, 0xff

descript_q7:
.byte T_, h_, i_, n_, g_, s_, 0xff

descript_q8:
.byte A_, i_, d_, Space, G_, r_, e_, n_, z_, o_, Space, I_, n_, Space, D_, e_, f_, e_, a_, t_, i_, n_, g_, NewLine, H_, i_, s_, Space, R_, i_, v_, a_, l_, 0xff

descript_q9:
.byte t_, e_, s_, t_, NewLine, S_, h_, e_, n_, a_, n_, i_, g_, a_, n_, s_, 0xff

descript_q10:
.byte b_, l_, a_, h_, 0xff

descript_q11:
.byte h_, m_, m_, 0xff

descript_q12:
.byte C_, a_, p_, t_, u_, r_, e_, Space, A_, NewLine, S_, q_, u_, i_, r_, t_, l_, e_, 0xff

descript_q13:
.byte D_, e_, f_, e_, a_, t_, Space, _1_, _0_, NewLine, T_, r_, a_, i_, n_, e_, r_, s_, 0xff

descript_q14:
.byte C_, o_, m_, p_, l_, e_, t_, e_, Space, _2_, _0_, Percent, NewLine, O_, f_, Space, t_, h_, e_, Space, P_, o_, k_, e_acute_, d_, e_, x_, 0xff

descript_q15:
.byte A_, g_, e_, n_, d_, a_, 0xff

descript_q16:
.byte T_, e_, s_, t_, 0xff

descript_q17:
.byte J_, o_, i_, n_, Space, T_, h_, e_, Space, M_, a_, f_, i_, a_, 0xff

descript_q18:
.byte S_, t_, e_, a_, l_, Space, A_, Space, P_, o_, t_, i_, o_, n_, 0xff

descript_q19:
.byte H_, a_, t_, c_, h_, Space, _2_, _0_, Space, E_, g_, g_, s_, 0xff

descript_q20:
.byte D_, e_, f_, e_, a_, t_, Space, G_, y_, m_, Space, _7_, 0xff

descript_q21:
.byte F_, i_, n_, d_, Space, _1_, _0_, Space, C_, o_, m_, e_, t_, Space, S_, h_, a_, r_, d_, s_, 0xff

descript_q22:
.byte T_, e_, s_, t_, i_, n_, g_, 0xff

descript_q23:
.byte S_, t_, u_, f_, f_, Space, P_, a_, r_, t_, Space, _2_, 0xff

descript_q24:
.byte Y_, e_, t_, Space, A_, n_, o_, t_, h_, e_, r_, NewLine, T_, e_, s_, t_, Space, C_, a_, s_, e_, 0xff

descript_q25:
.byte O_, b_, t_, a_, i_, n_, Space, A_, Space, M_, a_, s_, t_, e_, r_, b_, a_, l_, l_, 0xff

descript_q26:
.byte E_, v_, o_, l_, v_, e_, Space, A_, Space, C_, u_, t_, b_, i_, t_, 0xff

descript_q27:
.byte D_, o_, Space, S_, o_, m_, e_, t_, h_, i_, n_, g_, Space, C_, o_, o_, l_, 0xff

descript_q28:
.byte S_, a_, v_, e_, Space, S_, o_, m_, e_, t_, h_, i_, n_, g_, 0xff

descript_q29:
.byte H_, i_, 0xff

descript_q30:
.byte P_, e_, r_, f_, o_, r_, m_, NewLine, T_, h_, i_, s_, NewLine, A_, c_, t_, i_, o_, n_, 0xff


descript_cancel:
.byte E_, x_, i_, t_, Space, M_, e_, n_, u_, 0xff

descript_unk:
.byte U_, n_, k_, n_, o_, w_, n_, 0xff
