GAME_VERSION       ?= RUSH2
GAME_REGION        ?= EUROPE
GAME_REVISION 	   ?= REV_00

ifeq ($(GAME_VERSION),RUSH2)
buildname     := rush2
shortname     := sra
TITLE_NAME    := SONICRUSHADV
GAME_CODE     := A3Y
else
	ifeq ($(GAME_VERSION),RUSH2_CONTEST)
buildname     := rush2.contest
shortname     := r2vs
TITLE_NAME    := NINTENDO    
GAME_CODE     := NTR
	endif
endif

ifeq ($(GAME_VERSION),RUSH2_CONTEST)
buildname := $(buildname)
GAME_CODE := $(GAME_CODE)J
else
	ifeq ($(GAME_REGION),EUROPE)
buildname := $(buildname).eu
GAME_CODE := $(GAME_CODE)P
	else
		ifeq ($(GAME_REGION),USA)
buildname := $(buildname).us
GAME_CODE := $(GAME_CODE)E
		else
			ifeq ($(GAME_REGION),JAPAN)
buildname := $(buildname).jp
GAME_CODE := $(GAME_CODE)J
			else
$(error Unsupported game region: $(GAME_REGION))
			endif
		endif
	endif
endif

ifeq ($(GAME_REVISION),REV01)
buildname += .rev01
REMASTER_VERSION := 1
else
REMASTER_VERSION := 0
endif

BUILD_DIR         := $(ROOT_DIR)build/$(buildname)
ELFNAME           := arm9
ROM_PADDING		  := TRUE

GF_DEFINES  := -D$(GAME_VERSION) -DRUSH2_$(GAME_REVISION) -DRUSH2_$(GAME_REGION)

ifeq ($(GAME_VERSION),RUSH2_CONTEST)
GF_DEFINES  += -DRUSH_CONTEST
endif

ifeq ($(NO_GF_ASSERT),)
GF_DEFINES  += -DRUSH_KEEP_ASSERTS
endif

GLB_DEFINES := -DSDK_CODE_ARM

ifeq ($(DEBUG),1)
# add debug defines
GF_DEFINES += -DRUSH_DEBUG
GLB_DEFINES += -DSDK_DEBUG

# padding not needed in debug mode!
ROM_PADDING := FALSE
else
# SDK_FINALROM only needed if not in debug mode!
GLB_DEFINES += -DSDK_FINALROM
endif

ifeq ($(BUILD_MODE),ARM7)
GLB_DEFINES += -DSDK_ARM7
else
GLB_DEFINES += -DSDK_ARM9
endif

GLB_DEFINES += -D_NITRO
GLB_DEFINES += -DSDK_TS

DEFINES = $(GF_DEFINES) $(GLB_DEFINES)

# Secure CRC
ifeq ($(buildname),rush2.eu)
SECURE_CRC := 0xFEB4
else

ifeq ($(buildname),rush2.eu.rev01)
SECURE_CRC := 0xCF56
else

ifeq ($(buildname),rush2.us)
SECURE_CRC := 0x722A
else

ifeq ($(buildname),rush2.jp)
SECURE_CRC := 0x3985
else

ifeq ($(buildname),rush2.contest)
SECURE_CRC := 0x2690
endif

endif

endif

endif

endif

ifndef SECURE_CRC
	$(error Unsupported ROM: $(GAME_VERSION) $(GAME_LANGUAGE) $(GAME_REGION))
endif

# At present this repository only properly supports the 1.0 EU ROM
SUPPORTED_ROMS   := rush2.eu rush2.eu.rev01 rush2.us rush2.jp rush2.contest
ifneq ($(filter $(buildname),$(SUPPORTED_ROMS)),$(buildname))
$(error $(buildname) is not supported, choose from: $(SUPPORTED_ROMS))
endif
