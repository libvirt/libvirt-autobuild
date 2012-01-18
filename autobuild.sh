#!/bin/sh

set -e
set -v

# Make things clean.
test -n "$1" && RESULTS=$1 || RESULTS=results.log
: ${AUTOBUILD_INSTALL_ROOT=$HOME/builder}

test -f Makefile && make -k distclean || :

rm -rf build
mkdir build
cd build

../autogen.sh --prefix=$AUTOBUILD_INSTALL_ROOT

make
make install

rm -f *.tar.gz
make dist

if [ -n "$AUTOBUILD_COUNTER" ]; then
  EXTRA_RELEASE=".auto$AUTOBUILD_COUNTER"
else
  NOW=`date +"%s"`
  EXTRA_RELEASE=".$USER$NOW"
fi

if [ -f /usr/bin/rpmbuild ]; then
  rpmbuild --nodeps \
     --define "extra_release $EXTRA_RELEASE" \
     --define "_sourcedir `pwd`" \
     -ba --clean libvirt-autobuild.spec
fi
