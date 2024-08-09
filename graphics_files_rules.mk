$(CLOBBER_SIZE_NCGR_FILES): GFX_FLAGS = -clobbersize
$(CLOBBER_SIZE_VERSION101_NCGR_FILES): GFX_FLAGS = -clobbersize -version101
$(VERSION101_SOPC_8BPP_NCGR_FILES): GFX_FLAGS = -version101 -sopc -bitdepth 8
$(VERSION101_SOPC_NCGR_FILES): GFX_FLAGS = -version101 -sopc
$(SCANNED_NCGR_FILES): GFX_FLAGS = -scanned

$(IR_NCLR_FILES): GFX_FLAGS = -ir
$(4BPP_NCLR_FILES): GFX_FLAGS = -bitdepth 4
$(8BPP_NSCR_FILES): GFX_FLAGS = -bitdepth 8
$(8BPP_COMP10_NOPAD_NCLR_PNG_FILES): GFX_FLAGS = -bitdepth 8 -nopad -comp 10
$(8BPP_COMP10_NOPAD_NCLR_PAL_FILES): GFX_FLAGS = -bitdepth 8 -nopad -comp 10
$(4BPP_NOPAD_PCMP_NCLR_FILES): GFX_FLAGS = -bitdepth 4 -nopad -pcmp

LZ_FLAGS                     := -l2 -s

%.NCGR: %.png
	$(GFX) $< $@ $(GFX_FLAGS)

%.NCLR: %.png
	$(GFX) $< $@ $(GFX_FLAGS)

%.NCLR: %.pal
	$(GFX) $< $@ $(GFX_FLAGS)

%.nbfc: %.png
	$(GFX) $< $@ $(GFX_FLAGS)

%.nbfp: %.png
	$(GFX) $< $@ $(GFX_FLAGS)

%.lz: %
	$(NTRCOMP) $(LZ_FLAGS) -o $@ $<

%.bblst: %
	$(ARCHIVEPACK) $<
