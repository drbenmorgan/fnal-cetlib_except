#!/bin/bash
# Simple bundle of install deps - to be better handled through PM
# i.e.
#  "packagemanager install/setup dep1 dep2"

# Should have Travis env vars
if [ "$TRAVIS_OS_NAME" == "osx" ] ; then
  brew update
  brew outdated cmake || brew upgrade cmake
elif [ "$TRAVIS_OS_NAME" == "linux" ] ; then
  wget https://cmake.org/files/v3.9/cmake-3.9.3-Linux-x86_64.tar.gz
  tar -xf cmake-3.9.3-Linux-x86_64.tar.gz
  export PATH=$(pwd)/cmake-3.9.3-Linux-x86_64/bin:$PATH
fi

# Cache current dir, so we can get back to it
# (This is probably set in a Travis variable)
basedir=$(pwd)
LOCALDEP_SOURCEDIR="$HOME/dep_build"
LOCALDEP_INSTALLDIR="$HOME/dep_install"
export CMAKE_PREFIX_PATH="$LOCALDEP_INSTALLDIR"

# For cetlib_except, need cetbuildtools2 only, custom branch (yep, hacky)
# for now.
cd "$LOCALDEP_SOURCEDIR"
git clone https://github.com/drbenmorgan/cetbuildtools2.git
cd cetbuildtools2
cmake -DCMAKE_INSTALL_PREFIX="$LOCALDEP_INSTALLDIR" .
make install

# Get back to where we were
cd "$basedir"

