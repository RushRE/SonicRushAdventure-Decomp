BUILD_MODE     := ARM9
ROOT_DIR       := 
MWCCVER        := 2.0/sp1p5
PROC           := arm946e
PROC_S         := arm5te
PROC_LD        := v5te
LCF_TEMPLATE   := ARM9-TS.lcf.template
LIBS           := -Llib -lsyscall -nostdlib
OPTFLAGS       := -O4,p -nodeadstrip

# don't compare if we're adding extra debug stuff
ifeq ($(DEBUG),1)
OPTFLAGS       := -O1,p
endif

include config.mk

ALL_BUILDDIRS  := $(BUILD_DIR)/lib
include common.mk

include filesystem.mk

# Locate crt0.o
CRT0_OBJ := lib/NitroSDK/src/init/ARM9/crt0.o

$(ASM_OBJS): $(WORK_DIR)/include/config.h
$(C_OBJS):   $(WORK_DIR)/include/global.h

ROM             := $(BUILD_DIR)/$(buildname).nds
BANNER          := $(ROM:%.nds=%.bnr)
BANNER_SPEC     := $(buildname)/banner.bsf
ICON_PNG        := $(buildname)/icon.png
HEADER_TEMPLATE := $(buildname)/rom_header_template.sbin

.PHONY: arm9 arm9.contest arm7 libsyscall sdk sdk9 sdk7
.PRECIOUS: $(ROM)

MAKEFLAGS += --no-print-directory

all:
	$(MAKE) tools
	$(MAKE) patch_mwasmarm
	$(MAKE) $(ROM)

tidy:
	@$(MAKE) -C lib/syscall tidy
	@$(MAKE) -C sub tidy
	$(RM) -r $(BUILD_DIR)
	$(RM) -r $(PROJECT_CLEAN_TARGETS)
	$(RM) $(ROM)

clean: tidy clean-filesystem clean-tools
	@$(MAKE) -C lib/syscall clean
	@$(MAKE) -C sub clean

SBIN_LZ        := $(SBIN)_LZ
.PHONY: arm9_lz

sdk9 sdk7: sdk
arm9 files_for_compile: | sdk9
arm7: | sdk7

arm9: $(SBIN) $(ELF)
arm9_lz: $(SBIN_LZ)
arm7: ; @$(MAKE) -C sub

ifeq ($(GAME_VERSION),RUSH_CONTEST)
ROMSPEC        := rom.contest.rsf
else
ROMSPEC        := rom.rsf
endif

MAKEROM_FLAGS  := $(DEFINES)

$(ALL_OBJS): files_for_compile
$(ELF): files_for_compile libsyscall

libsyscall: files_for_compile
	$(MAKE) -C lib/syscall all install INSTALL_PREFIX=$(abspath $(WORK_DIR)/$(BUILD_DIR)) GAME_CODE=$(GAME_CODE)

$(SBIN_LZ): $(BUILD_DIR)/component.files
	$(COMPSTATIC) -9 -c -f $<

$(BUILD_DIR)/component.files: arm9 ;

$(HEADER_TEMPLATE): ;

$(ROM): $(ROMSPEC) filesystem arm9_lz arm7 $(BANNER)
	$(WINE) $(MAKEROM) $(MAKEROM_FLAGS) -DBUILD_DIR=$(BUILD_DIR) -DNITROFS_FILES="$(NITROFS_FILES:resources/%=%)" -DTITLE_NAME="$(TITLE_NAME)" -DROM_PADDING="$(ROM_PADDING)" -DREMASTER_VERSION="$(REMASTER_VERSION)" -DBNR="$(BANNER)" -DHEADER_TEMPLATE="$(HEADER_TEMPLATE)" $< $@
	$(FIXROM) $@ --secure-crc $(SECURE_CRC) --game-code $(GAME_CODE)
ifeq ($(COMPARE),1)
	$(SHA1SUM) -c $(buildname)/rom.sha1
endif

$(BANNER): $(BANNER_SPEC) $(ICON_PNG:%.png=%.nbfp) $(ICON_PNG:%.png=%.nbfc)
	$(WINE) $(MAKEBNR) $< $@

# TODO: move to NitroSDK makefile

FX_CONST_H := $(WORK_DIR)/lib/include/nitro/fx/fx_const.h
PROJECT_CLEAN_TARGETS += $(FX_CONST_H)
$(FX_CONST_H): $(MKFXCONST) $(TOOLSDIR)/gen_fx_consts/fx_const.csv
	$(MKFXCONST) $@
sdk: $(FX_CONST_H)
$(WORK_DIR)/include/global.h: $(FX_CONST_H) ;

# Convenience targets
rush2:          ; @$(MAKE) GAME_VERSION=RUSH2 COMPARE=1
clean_rush2:    ; @$(MAKE) GAME_VERSION=RUSH2 clean

rush2_contest:          ; @$(MAKE) GAME_VERSION=RUSH_CONTEST
clean_rush2_contest:    ; @$(MAKE) GAME_VERSION=RUSH_CONTEST clean

.PHONY: rush2 clean_rush2 debug_rush2 rush2_contest clean_rush2_contest rush2_child clean_rush2_child
