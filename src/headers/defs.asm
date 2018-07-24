.text
.align 2
.thumb
.thumb_func
.global definitions

.equ NumQuests, 30

.equ StartFlags, 0x2100
.equ DoneFlags, 0x2200

.equ sideboxID, 0x02037101

.equ QuestFlag, 0x0203e061
.equ ActiveQuest, 0x0203c014

.equ PokemonFlag,0x828
.equ PokedexFlag, 0x829
.equ MapFlag, 0x250
.equ QuestsFlag, 0x24d
.equ PSSFlag, 0x24e
.equ SaveFlag, 0x24f
.equ SafariFlag, 0x800

.equ CurrentMap, 0x02036dfc
.equ DisplayedString, 0x02021d18
.equ var8000, 0x020370b8
.equ var8001, 0x020370ba
.equ var8002, 0x020370bc
.equ var8003, 0x020370be
.equ var8004, 0x020370c0
.equ var8005, 0x020370c2
.equ var8006, 0x020370c4
.equ var8007, 0x020370c6
.equ var8008, 0x020370c8
.equ var8009, 0x020370ca
.equ var800a, 0x020370cc
.equ var800b, 0x020370ce
.equ var800d, 0x020370d0
.equ var800f, 0x020370d2
.equ var800c, 0x020370d4
.equ var8010, 0x020370d6
.equ var8011, 0x020370d8

.equ start_menu_callback, 0x080568a8
.equ check_flag, 0x0806e6d0
.equ set_callback2, 0x08000544
.equ GetAttr, 0x0803fbe8

.equ NormalMap, 0x080a1cc0
.equ FlyMap, 0x080c4ef8
