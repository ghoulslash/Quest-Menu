.gba
.thumb
.open "bpre0.gba", 0x08000000		; rom start

.relativeinclude on		; include all folders from current path

.org 0x0806ed5c
ldr r0, =build_menu+1
bx r0
.pool

.org 0x0806ef9c
.word start_menu_opts
.pool
.org 0x0806f374
.word start_menu_opts
.pool

.org 0x0806f3f8
.word start_menu_opts
.pool

.org 0x080a1cdc
ldr r0, =townmap_callback+1		; set townmap callback to start menu if opened from start menu
bx r0
.pool
.org 0x080c5258
ldr r0, =flymap_callback+1		; set fly map callback to start menu if opened from start menu
bx r0
.pool

.org 0x080f78f0		; start menu width
.byte 0x8
.org 0x080f78f4		; start menu height check
ldr r0, =start_menu_size+1
bx r0
.pool
.org 0x080f790c		; start menu x position
.byte 0x01			; menu at left

.org 0x0810708c
ldr r0, =prevent_a+1	; do nothing when 'a' is pressed on unknown or completed quest
bx r0
.pool
.org 0x0810d87a
.byte 0,0
ldr r0, =quest_names+1
bx r0
.pool
.org 0x0810d974
ldr r0, =quest_descriptions+1
bx r0
.pool
.org 0x0810da60
ldr r0, =quest_status+1
bx r0
.pool
.org 0x0810db38
ldr r0, =header_box+1
bx r0
.pool
.org 0x0810ddae
.byte 0, 0
ldr r0, =num_quests+1
bx r0
.pool
.org 0x0810decc
ldr r0, =prevent_select+1
bx r0
.pool
.org 0x0810e2b4
ldr r0, =opt_strings+1
bx r0
.pool
.org 0x0810e384
ldr r0, =quest_opts+1
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

.org 0x08990000		; where to insert into rom (above ebcf8)
.importobj "build/linked.o"
.close