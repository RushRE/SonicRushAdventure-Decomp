CC := gcc
CFLAGS := -O3 -Wno-unused-result

.PHONY: all clean

all: archivepack
	@:

archivepack: archivepack.c cJSON.c
	$(CC) $(CFLAGS) -o $@ $^

clean:
	$(RM) archivepack archivepack.exe
