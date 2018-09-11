.text
.align 2
.thumb
.thumb_func
.global definitions

/*	CHANGE THESE	*/
.equ NumQuests, 5
.equ ActivatedFlags, 0x2100
.equ CompletedFlags, 0x2200
.equ QuestFlag, 0x0203e050		@ free ram byte -> flag for hack to function
.equ ActiveQuest, 0x0203c014	@ free ram byte -> active quest index

.equ CurrentMap, 0x02036dfc
.equ DisplayedString, 0x02021d18
.equ var8007, 0x020370c6
.equ check_flag, 0x0806e6d0
.equ set_callback2, 0x08000544
