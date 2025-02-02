## Common defines for ARM9 and ARM7 Makefiles ##

ifeq ($(DEBUG),1)
COMPARE ?= 0 # don't compare if we're adding extra debug stuff
else
COMPARE ?= 1
endif

default: all

PROJECT_ROOT := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

ifeq ($(OS),Windows_NT)
REALPATH := realpath
else
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
REALPATH ?= grealpath
else
REALPATH := realpath
endif
endif

# Because mwldarm expects absolute paths to be WIN32 paths,
# all paths referring up from BUILD_DIR must be relative.
WORK_DIR   := $(shell $(REALPATH) --relative-to $(CURDIR) $(PROJECT_ROOT))
$(shell mkdir -p $(BUILD_DIR))
BACK_REL   := $(shell $(REALPATH) --relative-to $(BUILD_DIR) $(CURDIR))

# Recursive wildcard function
rwildcard=$(foreach d,$(wildcard $(1:=/*)),$(call rwildcard,$d,$2) $(filter $(subst *,%,$2),$d))

TOOLSDIR     := $(WORK_DIR)/tools

include $(WORK_DIR)/platform.mk
include $(WORK_DIR)/binutils.mk

# NitroSDK tools
MWCC          = $(TOOLSDIR)/mwccarm/$(MWCCVER)/mwccarm.exe
MWAS          = $(TOOLSDIR)/mwccarm/$(MWCCVER)/mwasmarm.exe
MWLD          = $(BACK_REL)/$(TOOLSDIR)/mwccarm/$(MWCCVER)/mwldarm.exe
MAKEROM      := $(TOOLSDIR)/bin/makerom.exe
MAKELCF      := $(TOOLSDIR)/bin/makelcf.exe
MAKEBNR      := $(TOOLSDIR)/bin/makebanner.exe
NTRCOMP      := $(TOOLSDIR)/bin/ntrcomp.exe

export LM_LICENSE_FILE := $(TOOLSDIR)/mwccarm/license.dat

# Native tools
ROMEXTRACT   := $(TOOLSDIR)/romextract/romextract$(EXE)
ARCHIVEPACK  := $(TOOLSDIR)/archivepackex/archivepackex$(EXE)
GFX          := $(TOOLSDIR)/nitrogfx/nitrogfx$(EXE)
FIXROM       := $(TOOLSDIR)/fixrom/fixrom$(EXE)
ASPATCH      := $(TOOLSDIR)/mwasmarm_patcher/mwasmarm_patcher$(EXE)
MKFXCONST    := $(TOOLSDIR)/gen_fx_consts/gen_fx_consts$(EXE)

# Decompiled NitroSDK tools
COMPSTATIC   := $(TOOLSDIR)/compstatic/compstatic$(EXE)

ASM_PROCESSOR := $(TOOLSDIR)/asm_processor/compile.sh

NATIVE_TOOLS := \
	$(ROMEXTRACT) \
	$(ARCHIVEPACK) \
	$(GFX) \
	$(FIXROM) \
	$(ASPATCH) \
	$(MKFXCONST) \
	$(COMPSTATIC)

TOOLDIRS := $(foreach tool,$(NATIVE_TOOLS),$(dir $(tool)))

# Directories

# NitroSDK
NITROSYSTEM_SRC_SUBDIRS   := 
NITROWIFI_SRC_SUBDIRS     := 
NITRODWC_SRC_SUBDIRS      := 
NITROSDK_SRC_SUBDIRS      := init/$(BUILD_MODE) fx gx os os/$(BUILD_MODE) mi snd pxi pad pad/$(BUILD_MODE) fs dgt cp spi spi/$(BUILD_MODE) rtc rtc/$(BUILD_MODE) card card/$(BUILD_MODE) wm mb ctrdg ctrdg/$(BUILD_MODE) math cht cht/$(BUILD_MODE) std 

ifeq ($(BUILD_MODE),ARM7)
NITROSDK_SRC_SUBDIRS      := init/$(BUILD_MODE) os os/$(BUILD_MODE) mi snd_TODO_THIS pxi pad pad/$(BUILD_MODE) fs spi spi/$(BUILD_MODE) rtc rtc/$(BUILD_MODE) card card/$(BUILD_MODE) wvr ctrdg ctrdg/$(BUILD_MODE) math
else
# set this here so arm7 doesn't try to compile it
NITROSYSTEM_SRC_SUBDIRS   := fnd g2d g3d gfd snd g2d/internal g2d/load g3d/binres g3d/anm g3d/cgtool
NITROWIFI_SRC_SUBDIRS     := 
NITRODWC_SRC_SUBDIRS      := base account
endif


LIB_SUBDIRS               := cw NitroSDK NitroSystem NitroDWC NitroWiFi libCPS libSSL
SRC_SUBDIR                := src
ASM_SUBDIR                := asm
LIB_SRC_SUBDIR            := lib/src $(LIB_SUBDIRS:%=$(ROOT_DIR)lib/%/src) $(NITROSDK_SRC_SUBDIRS:%=$(ROOT_DIR)lib/NitroSDK/src/%) $(NITROSYSTEM_SRC_SUBDIRS:%=$(ROOT_DIR)lib/NitroSystem/src/%) $(NITROWIFI_SRC_SUBDIRS:%=$(ROOT_DIR)lib/NitroWiFi/src/%) $(NITRODWC_SRC_SUBDIRS:%=$(ROOT_DIR)lib/NitroDWC/src/%)
LIB_ASM_SUBDIR            := lib/asm/$(BUILD_MODE) $(LIB_SUBDIRS:%=$(ROOT_DIR)lib/%/asm/$(BUILD_MODE)) $(NITROSYSTEM_SRC_SUBDIRS:%=$(ROOT_DIR)lib/NitroSystem/asm/%) $(NITROWIFI_SRC_SUBDIRS:%=$(ROOT_DIR)lib/NitroWiFi/asm/%) $(NITRODWC_SRC_SUBDIRS:%=$(ROOT_DIR)lib/NitroDWC/asm/%)
ALL_SUBDIRS               := $(SRC_SUBDIR) $(ASM_SUBDIR) $(LIB_SRC_SUBDIR) $(LIB_ASM_SUBDIR)

SRC_BUILDDIR              := $(addprefix $(BUILD_DIR)/,$(SRC_SUBDIR))
ASM_BUILDDIR              := $(addprefix $(BUILD_DIR)/,$(ASM_SUBDIR))
LIB_SRC_BUILDDIR          := $(addprefix $(BUILD_DIR)/,$(LIB_SRC_SUBDIR))
LIB_ASM_BUILDDIR          := $(addprefix $(BUILD_DIR)/,$(LIB_ASM_SUBDIR))

ifeq ($(BUILD_MODE),ARM7)

C_SRCS                    := 
CXX_SRCS                  := 
ASM_SRCS                  := 
GLOBAL_ASM_SRCS           != grep -rl 'GLOBAL_ASM(' $(C_SRCS)
LIB_C_SRCS                := $(foreach dname,$(LIB_SRC_SUBDIR),$(wildcard $(dname)/*.c))
LIB_ASM_SRCS              := $(foreach dname,$(LIB_ASM_SUBDIR),$(wildcard $(dname)/*.s))
ALL_SRCS                  := $(C_SRCS) $(ASM_SRCS) $(GLOBAL_ASM_SRCS) $(LIB_C_SRCS) $(LIB_ASM_SRCS)

C_OBJS                    := $(C_SRCS:../%.c=$(BUILD_DIR)/%.o)
ASM_OBJS                  := $(ASM_SRCS:../%.s=$(BUILD_DIR)/%.o)
GLOBAL_ASM_OBJS           := $(GLOBAL_ASM_SRCS:../%.c=$(BUILD_DIR)/%.o)
LIB_C_OBJS                := $(LIB_C_SRCS:../%.c=$(BUILD_DIR)/%.o)
LIB_ASM_OBJS              := $(LIB_ASM_SRCS:../%.s=$(BUILD_DIR)/%.o)
ALL_GAME_OBJS             := $(C_OBJS) $(ASM_OBJS) $(GLOBAL_ASM_OBJS)
ALL_LIB_OBJS              := $(LIB_C_OBJS) $(LIB_ASM_OBJS)
ALL_OBJS                  := $(ALL_GAME_OBJS) $(ALL_LIB_OBJS)

else

C_SRCS                    := $(call rwildcard,$(SRC_SUBDIR),*.c)
CXX_SRCS                  := $(call rwildcard,$(SRC_SUBDIR),*.cpp)
ASM_SRCS                  ?= $(call rwildcard,$(ASM_SUBDIR),*.s)
GLOBAL_ASM_SRCS           != grep -rl 'GLOBAL_ASM(' $(C_SRCS) $(CXX_SRCS)
LIB_C_SRCS                := $(foreach dname,$(LIB_SRC_SUBDIR),$(wildcard $(dname)/*.c))
LIB_ASM_SRCS              ?= $(foreach dname,$(LIB_ASM_SUBDIR),$(wildcard $(dname)/*.s))
ALL_SRCS                  := $(C_SRCS) $(CXX_SRCS) $(ASM_SRCS) $(GLOBAL_ASM_SRCS) $(LIB_C_SRCS) $(LIB_ASM_SRCS)

C_OBJS                    := $(C_SRCS:%.c=$(BUILD_DIR)/%.o)
CXX_OBJS                  := $(CXX_SRCS:%.cpp=$(BUILD_DIR)/%.o)
ASM_OBJS                  := $(ASM_SRCS:%.s=$(BUILD_DIR)/%.o)
GLOBAL_ASM_OBJS           := $(GLOBAL_ASM_SRCS:%.c=$(BUILD_DIR)/%.o)
LIB_C_OBJS                := $(LIB_C_SRCS:%.c=$(BUILD_DIR)/%.o)
LIB_ASM_OBJS              := $(LIB_ASM_SRCS:%.s=$(BUILD_DIR)/%.o)
ALL_GAME_OBJS             := $(C_OBJS) $(CXX_OBJS) $(ASM_OBJS) $(GLOBAL_ASM_OBJS)
ALL_LIB_OBJS              := $(LIB_C_OBJS) $(LIB_ASM_OBJS)
ALL_OBJS                  := $(ALL_GAME_OBJS) $(ALL_LIB_OBJS)

endif

$(ALL_LIB_OBJS): DEFINES = $(GLB_DEFINES)

ALL_BUILDDIRS     := $(sort $(ALL_BUILDDIRS) $(foreach obj,$(ALL_OBJS),$(dir $(obj))))

ELF               := $(BUILD_DIR)/$(ELFNAME).elf
LCF               := $(ELF:%.elf=%.lcf)
RESPONSE          := $(ELF:%.elf=%.response)
SBIN              := $(ELF:%.elf=%.sbin)
XMAP              := $(ELF).xMAP

EXCCFLAGS         		:= -Cpp_exceptions off
IPA_FLAG 		   		:= -ipa file

INLINE_FLAG 			:= -inline on,noauto
ifeq ($(DEBUG),1)
INLINE_FLAG       := -inline off
endif


$(BUILD_DIR)/lib/NitroSDK/%.o: IPA_FLAG := 
$(BUILD_DIR)/lib/NitroSystem/%.o: IPA_FLAG := 
$(BUILD_DIR)/lib/NitroDWC/%.o: IPA_FLAG := 
$(BUILD_DIR)/lib/NitroWiFi/%.o: IPA_FLAG := 

MWCFLAGS           = $(DEFINES) $(OPTFLAGS) -sym on -enum int -lang c99 $(EXCCFLAGS) -gccext,on -proc $(PROC) -msgstyle gcc -gccinc -i ./include -i ./include/library -I$(WORK_DIR) -I$(WORK_DIR)/tools/cw/include/MSL_C -I$(WORK_DIR)/tools/cw/include/MSL_Extras -I$(WORK_DIR)/lib/include -I$(WORK_DIR)/lib/include/dwc/gs $(IPA_FLAG) -interworking $(INLINE_FLAG) -char signed -W all -W pedantic -W noimpl_signedunsigned -W noimplicitconv -W nounusedarg -W nomissingreturn -W error 

MWASFLAGS          = $(DEFINES) -proc $(PROC_S) -g -gccinc -i . -i ./include -i $(WORK_DIR)/asm/include -i $(WORK_DIR)/lib/asm/$(BUILD_MODE)/include -i $(WORK_DIR)/lib/NitroDWC/asm/$(BUILD_MODE)/include -i $(WORK_DIR)/lib/NitroSDK/asm/$(BUILD_MODE)/include -i $(WORK_DIR)/lib/syscall/asm/include -I$(WORK_DIR)/lib/include -DSDK_ASM
MWLDFLAGS         := -proc $(PROC) -sym on -nopic -nopid -interworking -map closure,unused -symtab sort -m _start -msgstyle gcc

MW_COMPILE = $(WINE) $(MWCC) $(MWCFLAGS)
MW_ASSEMBLE = $(WINE) $(MWAS) $(MWASFLAGS)

export MWCIncludes := $(ROOT_DIR)lib/include -I$(WORK_DIR)/lib/include/dwc/gs

LSF               := $(addsuffix .lsf,$(ELFNAME))
ifneq ($(LSF),)
OVERLAYS          := $(shell $(GREP) -o "^Overlay \w+" $(LSF) | cut -d' ' -f2)
else
OVERLAYS          :=
endif

# Make sure build directories exist before compiling anything
DUMMY := $(shell mkdir -p $(ALL_BUILDDIRS))

.SECONDARY:
.SECONDEXPANSION:
.DELETE_ON_ERROR:
.PHONY: all tidy clean tools clean-tools patch_mwasmarm $(TOOLDIRS)
.PRECIOUS: $(SBIN)

patch_mwasmarm:
	$(ASPATCH) -q $(MWAS)

ifeq ($(NODEP),)

ifneq ($(WINPATH),)
PROJECT_ROOT_NT := $(shell $(WINPATH) -w $(PROJECT_ROOT) | $(SED) 's/\\/\//g')
define fixdep
$(SED) -i 's/\r//g; s/\\/\//g; s/\/$$/\\/g; s#$(PROJECT_ROOT_NT)#$(PROJECT_ROOT)#g' $(1)
touch -r $(1:%.d=%.o) $(1)
endef

else

define fixdep
$(SED) -i 's/\r//g; s/\\/\//g; s/\/$$/\\/g' $(1)
touch -r $(1:%.d=%.o) $(1)
endef

endif
DEPFLAGS := -gccdep -MD
DEPFILES := $(ALL_OBJS:%.o=%.d)
MW_COMPILE += $(DEPFLAGS)
$(GLOBAL_ASM_OBJS): BUILD_C := $(ASM_PROCESSOR) "$(MW_COMPILE)" "$(MW_ASSEMBLE)"
BUILD_C ?= $(MW_COMPILE) -c -o

$(DEPFILES):

# libraries are compiled with an older version and then linked to the game, so replicate that!
$(BUILD_DIR)/lib/NitroSDK/%.o: MWCCVER := 1.2/sp2p3
$(BUILD_DIR)/lib/NitroSystem/%.o: MWCCVER := 1.2/sp4
$(BUILD_DIR)/lib/NitroDWC/%.o: MWCCVER := 1.2/sp4
$(BUILD_DIR)/lib/NitroWiFi/%.o: MWCCVER := 1.2/sp4

lib/NitroSDK/%.c: MWCCVER := 1.2/sp2p3
lib/NitroSDK/%.s: MWCCVER := 1.2/sp2p3
lib/NitroSystem/%.c: MWCCVER := 1.2/sp4
lib/NitroSystem/%.s: MWCCVER := 1.2/sp4
lib/NitroDWC/%.c: MWCCVER := 1.2/sp4
lib/NitroDWC/%.s: MWCCVER := 1.2/sp4
lib/NitroWiFi/%.c: MWCCVER := 1.2/sp4
lib/NitroWiFi/%.s: MWCCVER := 1.2/sp4

$(BUILD_DIR)/%.o: $(ROOT_DIR)%.c
$(BUILD_DIR)/%.o: $(ROOT_DIR)%.cpp

$(BUILD_DIR)/%.o: $(ROOT_DIR)%.c $(BUILD_DIR)/%.d
	$(BUILD_C) $@ $<
	@$(call fixdep,$(BUILD_DIR)/$*.d)

$(BUILD_DIR)/%.o: $(ROOT_DIR)%.cpp $(BUILD_DIR)/%.d
	$(BUILD_C) $@ $<
	@$(call fixdep,$(BUILD_DIR)/$*.d)

$(BUILD_DIR)/%.o: $(ROOT_DIR)%.s
$(BUILD_DIR)/%.o: $(ROOT_DIR)%.s $(BUILD_DIR)/%.d
	$(WINE) $(MWAS) $(MWASFLAGS) $(DEPFLAGS) -o $@ $<
	@$(call fixdep,$(BUILD_DIR)/$*.d)

include $(wildcard $(DEPFILES))
else
$(GLOBAL_ASM_OBJS): BUILD_C := $(ASM_PROCESSOR) "$(MW_COMPILE)" "$(MW_ASSEMBLE)"
BUILD_C ?= $(MW_COMPILE) -c -o

$(BUILD_DIR)/%.o: $(ROOT_DIR)%.c
	$(BUILD_C) $@ $<

$(BUILD_DIR)/%.o: $(ROOT_DIR)%.cpp
	$(BUILD_C) $@ $<

$(BUILD_DIR)/%.o: $(ROOT_DIR)%.s
	$(WINE) $(MWAS) $(MWASFLAGS) -o $@ $<
endif

$(NATIVE_TOOLS): tools

tools: $(TOOLDIRS) $(MWAS)

$(TOOLDIRS):
	@$(MAKE) -C $@

clean-tools:
	$(foreach tool,$(TOOLDIRS),$(MAKE) -C $(tool) clean;)

$(LCF): $(LSF) $(LCF_TEMPLATE)
	$(WINE) $(MAKELCF) $(MAKELCF_FLAGS) $^ $@
ifeq ($(PROC),arm946e)
	$(SED) -i '1i KEEP_SECTION\n{\n\t.exceptix\n}' $@
else
	$(SED) -i '/\} > check\.WORKRAM/a SDK_SUBPRIV_ARENA_LO = SDK_SUBPRIV_ARENA_LO;' $@
endif

RESPONSE_TEMPLATE    := $(PROJECT_ROOT)/mwldarm.response.template
RESPONSE_TEMPLATE_NT := $(PROJECT_ROOT_NT)/mwldarm.response.template

$(RESPONSE): $(LSF) $(RESPONSE_TEMPLATE)
	$(WINE) $(MAKELCF) $(MAKELCF_FLAGS) $< $(RESPONSE_TEMPLATE_NT) $@

.INTERMEDIATE: $(BUILD_DIR)/obj.list

ifeq ($(BUILD_MODE),ARM7)
$(SBIN): $(BUILD_DIR)/%.sbin: $(BUILD_DIR)/%.elf
else
$(SBIN): build/%.sbin: build/%.elf
endif

ifeq ($(COMPARE),1)
	$(SHA1SUM) -c $*.sha1
endif

$(ELF): $(ALL_OBJS)
	$(MAKE) $(LCF)
	$(MAKE) $(RESPONSE)
	cd $(BUILD_DIR) && LM_LICENSE_FILE=$(BACK_REL)/$(LM_LICENSE_FILE) $(WINE) $(MWLD) $(MWLDFLAGS) $(LIBS) -o $(BACK_REL)/$(ELF) $(LCF:$(BUILD_DIR)/%=%) @$(RESPONSE:$(BUILD_DIR)/%=%) $(CRT0_OBJ)