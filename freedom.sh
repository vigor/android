!/bin/bash

#GCC Freedom

echo
echo
echo This will modify your build environment to allow for custom GCC use
echo
echo

DIR=$(pwd)

cd $DIR/build/
git fetch https://github.com/IAmTheOneTheyCallNeo/android_build cm-10.2-freedom && git cherry-pick f3fad78b59704464deabed17e595e8de2e634584

cd $DIR/external/oprofile/
git fetch https://github.com/IAmTheOneTheyCallNeo/android_external_oprofile cm-10.2 && git cherry-pick 8e47b75e800f47f7b5655dd0dcaa177091a75b04

cd $DIR/

echo
echo
echo Please visit https://github.com/IAmTheOneTheyCallNeo/android_build/commit/f3fad78b59704464deabed17e595e8de2e634584 for instructions
echo
echo

