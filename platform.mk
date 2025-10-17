# Check if building on Windows under Cygwin or MSYS2.
CYGWINLIKE := 0
UNAMESTR := $(shell uname 2>/dev/null || echo Unknown)
UNAMESTRSUBST := $(patsubst CYGWIN%,Cygwin,$(UNAMESTR))
UNAMESTRSUBST := $(patsubst MSYS%,Cygwin,$(UNAMESTRSUBST))
ifeq ($(UNAMESTRSUBST),Cygwin)
  CYGWINLIKE := 1
endif

WSLENV ?= no
ifeq ($(WSLENV),no)
  ifeq ($(CYGWINLIKE),1)
    NOWINE = 1
  else
    NOWINE = 0
  endif
else
  # As of build 17063, WSLENV is defined in both WSL1 and WSL2
  # so we need to use the kernel release to detect between
  # the two.
  UNAME_R := $(shell uname -r)
  ifeq ($(findstring WSL2,$(UNAME_R)),)
    NOWINE = 1
  else
    NOWINE = 0
  endif
endif

ifeq ($(OS),Windows_NT)
  EXE := .exe
  WINE :=
  GREP := grep -P
  SED := sed -r
  SHA1SUM := sha1sum
  MKTEMP := mktemp
else
  EXE :=
  WINE := wine
  UNAME_S := $(shell uname -s)
  ifeq ($(UNAME_S),Darwin)
    GREP := grep -E
    SED := gsed -r
    SHA1SUM := shasum
    MKTEMP := gmktemp
  else
    GREP := grep -P
    SED := sed -r
    SHA1SUM := sha1sum
    MKTEMP := mktemp
  endif
endif

ifeq ($(NOWINE),1)
  WINE :=
  WINPATH := wslpath
  ifeq ($(CYGWINLIKE),1)
    WINPATH := cygpath
  endif
else
  WINPATH := winepath
endif
