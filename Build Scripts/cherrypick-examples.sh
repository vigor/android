#!/bin/bash


# example of a customized patch
echo ""
echo ">>> this is a custom patch"
pushd directory/of/the/project 1>/dev/null
    git apply ~/Android/cm11.0-rezound/our_custom_patch-diff.patch || retval=1
popd 1>/dev/null
echo ">>> done; current result value : $retval"
if [ "$auto" == "0" ]; then read -p "press [enter] to continue..."; fi

# example of a custom git cherry-pick (not a cyanogenmod commit)
echo ""
echo ">>> example of a custom git cherry-pick"
pushd directory/of/the/project >/dev/null
    git cherry-pick SHA_HASH_OF_THE_CHERRY_PICK || retval=1
popd
echo ">>> done; current result value : $retval"
if [ "$auto" == "0" ]; then read -p "press [enter] to continue..."; fi

# example of a git revert
echo ""
echo ">>> example of a git revert"
pushd directory/of/the/project
    git revert --no-edit SHA_HASH_OF_THE_CHERRY_PICK || retval=1
popd
echo ">>> done; current result value : $retval"
if [ "$auto" == "0" ]; then read -p "press [enter] to continue..."; fi


