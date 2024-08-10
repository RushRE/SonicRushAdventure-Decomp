CC := gcc
CFLAGS := -O3 -Wno-unused-result

.PHONY: all clean

all: romextract
	@:

romextract: romextract.c rom.c archiveExtract.c fileNameTable.c compression.c stringUtils.c
	$(CC) $(CFLAGS) -o $@ $^

clean:
	$(RM) romextract romextract.exe
