BUILD_MODE   := ARM7

include ../config.mk

# Because mwldarm expects absolute paths to be WIN32 paths,
# all paths referring up from BUILD_DIR must be relative.
BACK_REL     := ..
TOOLSDIR     := ../tools
ELFNAME      := arm7
MWCCVER      := 2.0/sp1p5
PROC         := arm7tdmi
PROC_S       := arm4t
PROC_LD      := v4t
LCF_TEMPLATE := ARM7-TS.lcf.template
OPTFLAGS     := -O4,s

ROOT_DIR        := ../
BUILD_DIR       := build

# Locate crt0.o
CRT0_OBJ := lib/NitroSDK/src/init/ARM7/crt0.o

include ../common.mk

tidy:
	$(RM) -r $(BUILD_DIR)

clean: tidy

all:
	$(MAKE) patch_mwasmarm 
	$(MAKE) target

target: $(SBIN) $(ELF)

compare: COMPARE := 1
compare: all

