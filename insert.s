.gba
.thumb
.open "bpre0.gba", 0x08000000	; rom start

.relativeinclude on

.org 0x0810708c
ldr r0, =prevent_a+1	; do nothing when 'a' is pressed on unknown or completed quest
bx r0
.pool
.org 0x0810d840			; memory allocation
ldr r0, =quest_malloc+1
bx r0
.pool
.org 0x0810d87a
.byte 0,0
ldr r0, =quest_names+1	; display quest name strings
bx r0
.pool
.org 0x0810d97c
ldr r0, =quest_descriptions+1	; display quest descriptions when hovering over quest
bx r0
.pool
.org 0x0810da60
ldr r0, =quest_status+1		; active or done status at right
bx r0
.pool
.org 0x0810db38
ldr r0, =header_box+1		; side quests instead of withdraw item
bx r0
.pool
.org 0x0810ddae
.byte 0, 0
ldr r0, =num_quests+1		; store number of quests for loops and stuff
bx r0
.pool
.org 0x0810decc
ldr r0, =prevent_select+1	; cannot re-order quest names
bx r0
.pool
.org 0x0810e2b4
ldr r0, =quest_opt_strings+1	; selection options for quest
bx r0
.pool
.org 0x0810e2ec
ldr r0, =selected_msg+1			; message displayed when selected quest
bx r0
.pool
.org 0x0810e384
ldr r0, =quest_opt_funcs+1		; functions when selected a quest option
bx r0
.pool
.org 0x0810e434
ldr r0, =selected_string+1	; message displayed when quest is selected
bx r0
.pool
.org 0x080ebcf8
ldr r0, =quest_callback+1		; change callback function to start menu callback
bx r0
.pool

.org 0x08990000		; where to insert into rom
.importobj "build/linked.o"
.close