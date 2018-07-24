AS=arm-none-eabi-as
LD=arm-none-eabi-ld
ARS=armips

ASFLAGS=-mthumb
LDFLAGS=-z muldefs

BLDPATH:=build

rwildcard=$(wildcard $1$2) $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2))

ASSRC := $(call rwildcard,src/,*.asm)
ASOBJS := $(ASSRC:%.asm=$(BLDPATH)/%.o)

$(BLDPATH)/%.o: %.asm
	$(shell mkdir -p $(dir $@))
	$(AS) $(ASFLAGS) -c $< -o $@
	
all: $(ASOBJS)
	$(LD) $(LDFLAGS) -T linker.lsc --relocatable -o  "build\linked.o" $(ASOBJS)
	$(ARS)  insert.s