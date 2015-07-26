#! /bin/sh

set -x
aclocal
#libtoolize --force --copy
autoheader
automake --add-missing --copy -Wno-portability
autoconf

