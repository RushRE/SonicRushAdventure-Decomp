CC := gcc
CFLAGS := -O3 -Wno-unused-result

.PHONY: all clean

all: romextract
	@:

romextract: romextract.c
	$(CC) $(CFLAGS) -o $@ $^

clean:
	$(RM) romextract romextract.exe
