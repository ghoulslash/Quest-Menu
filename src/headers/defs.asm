.text
.align 2
.thumb
.thumb_func
.global definitions

/*	CHANGE THESE	*/
.equ NumQuests, xxxxxxxxxxxxxxx
.equ ActivatedFlags, xxxxxxxxxxxxxxx		@ start of flags that show quest name
.equ CompletedFlags, xxxxxxxxxxxxxxx		@ start of flags that indicate completed quest
.equ QuestFlag, 0x02xxxxxx				@ free ram byte -> flag for hack to function
.equ ActiveQuest, 0x02xxxxxx			@ free ram byte -> active quest index


.equ CurrentMap, 0x02036dfc
.equ DisplayedString, 0x02021d18
.equ var8007, 0x020370c6
.equ check_flag, 0x0806e6d0
.equ set_callback2, 0x08000544
