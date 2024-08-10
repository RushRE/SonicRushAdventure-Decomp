CC := gcc
CXXFLAGS := -std=c++17 -O2 -w
CFLAGS   := -O2 -w

LDFLAGS  += -lstdc++fs -DARCHIVEPACK_EX

C_SRCS   := ../archivepack/archivepack.c ../archivepack/cJSON.c
CXX_SRCS := archivepackex.cpp

C_OBJS   := $(C_SRCS:%.c=%.o)
CXX_OBJS := $(CXX_SRCS:%.cpp=%.o)
OBJS     := $(C_OBJS) $(CXX_OBJS)

.PHONY: all clean

all: archivepackex
	@:

archivepackex: $(CXX_SRCS) $(C_SRCS)
	$(CXX) $(C_SRCS) $(CXX_SRCS) -I../archivepack -o $@ $(LDFLAGS) $(CXXFLAGS)

clean:
	$(RM) archivepackex archivepackex.exe
