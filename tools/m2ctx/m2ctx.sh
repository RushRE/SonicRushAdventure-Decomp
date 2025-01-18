#!/usr/bin/env bash

OUT_FILE=ctx.c

GCC=gcc
FLAGS="-E -P -dD -undef"
INCLUDES="-Iinclude -Iinclude/library -I./ -Itools/cw/include/MSL_C -Itools/cw/include/MSL_Extras -Ilib/include/dwc/gs -Ilib/include -include global.h"
DEFINES="-DRUSH2 -DRUSH_REV00 -DRUSH_EUROPE -DRUSH_ENGLISH -DSDK_ARM9 -DSDK_CODE_ARM -DSDK_FINALROM -D_NITRO -DSDK_TS -D__arm -Dwchar_t=int"

generate-ctx () {
    # Remove any line containing a predefined macro. If not removed, mwccarm
    # generates compiler warnings.
    grep "^#include " "$1" | $GCC $FLAGS $INCLUDES $DEFINES  -x c - | sed '/__STDC__\|__STDC_VERSION__\|__STDC_VERSION__\|__STDC_HOSTED__\|#define __arm 1\|#define __has_intrinsic(_a) 0/d' > $OUT_FILE
}

usage () {
    echo "Generate a context file for decomp.me."
    echo "Usage: $0 [-h] [FILEPATH]"
    echo ""
    echo "Arguments:"
    echo "  FILEPATH      Source file used to generate ctx.c"
    echo ""
    echo "Options:"
    echo "  -h            Show this message and exit"
}

while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
  -h)
    usage
    exit 0
    ;;
  *)
    generate-ctx "$1"
    exit 0
    ;;
  esac
done
