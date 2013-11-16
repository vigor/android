#/bin/bash

# setup android
cd ~/Android/cm11.0-rezound
TOP="~/Android/cm11.0-rezound"; export TOP
source build/envsetup.sh

# setup ccache
export USE_CCACHE=1
export CCACHE_DIR="$HOME/.ccache_cm11.0-rezound"
ccache --max-size=8G   # Increase the cache to 8gb (sufficient for most builds)

# clobber if we supply clobber as arg1
if [ "$1" == 'clobber' ]
then
    make clobber
fi

# make, logging all to either build.err or build.log
{ time brunch vigor 2>build.err ; } 2>&1 | tee build.log 

# note - build log is in "build.log", syserrs encountered are in "build.err"
# any actual compilation errors will be in the build.log, not the build.err