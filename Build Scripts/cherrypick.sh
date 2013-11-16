#!/bin/bash

echo ""

auto=0

if [ "$1" == 'auto' ]
then
	auto='auto'
fi

check=0
if [ "$1" == 'check' ]
then
	check=1
	auto="auto"
        echo "Running in check mode ..."
        echo ""
fi

if [ "$auto" == "0" ]
then
    echo "Running in manual mode ..."
    echo ""
    read -p "press [enter] to continue..."
    echo ""
fi

if [ "$auto" == "auto" ]
then
    echo "Running in automatic mode ..."
    echo ""
fi

if [ "$auto" != 'auto' ]
then
    # check that wget is installed
    wget --version 2>/dev/null 1>/dev/null || {
       echo "Please make sure wget is installed"
       exit 1
    }
fi

retval=0
merged=0

rm -f cherryresult.txt

# cherrypicks;
#
# the # provided is the number of the commit desired on review.cyanogenmod.com
# the getcherrypick function will automatically change to the proper project directory
# and fetch the latest revision of the patch

# examples for a few different projects; tweak to suit your needs

# frameworks/av
getcherrypick 53324

# frameworks/native
getcherrypick 53161
getcherrypick 52994

# hardware/libhardware

# hardware/libhardware_legacy
getcherrypick 53165

# hardware/qcom/audio-caf
getcherrypick 53166
getcherrypick 53023
getcherrypick 53803

# android/build
getcherrypick 53559
 
if [ "$check" == '1' ]
then
    echo ""
    echo "Script result value : $retval" 
    echo ""
    exit 1
fi

echo ""
echo ""
echo "Done with CM Cherrypicks, current result value : $retval" 
echo ""
echo ""

dirs -c

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


if [ $retval -eq 0 ] && [ $merged -eq 1 ]
then
   retval=2
fi

if [ "$auto" = "auto" ]
then
    echo "$retval" > cherryresult.txt
    echo "Script result value : $retval" 
else
    echo ""
    echo "Script result value : $retval" 
    echo ""
fi

exit $retval

function getcherrypick()
{
    pick=$1

    commit=`echo "$pick" | cut -d\/ -f 1`

    wget -O commit.txt  http://review.cyanogenmod.com/query?format=TEXT\&current-patch-set=true\&q=change:$commit 1>/dev/null 2>/dev/null || {

            echo "Error!  Cannot contact gerrit to get cherrypick info!"
            retval=1
            return 1
    }

    patch=`echo "$pick" | cut -d\/ -f 2`

    if [ "$patch" == "$commit" ]
    then
        patch="`cat commit.txt | grep 'number' | tail -n 1 | cut -d\: -f 2 | cut -d\  -f 2`"
    fi

    status="`cat commit.txt | grep 'status' | tail -n 1 | cut -d\: -f 2 | cut -d\  -f 2`"
    subject="`cat commit.txt | grep 'subject' | tail -n 1 | sed 's/  subject: //g'`"
    project="`cat commit.txt | grep 'project' | tail -n 1 | sed 's/  project: //g'`"
    commitstr=`expr length "$commit" - 2`
    subpick=`echo ${pick:$commitstr:2}`
    dirname="`cat commit.txt | grep 'project' | tail -n 1 | cut -d\: -f 2 | cut -d\  -f 2`"
    gitpath=`repo list | grep "$dirname$" | cut -d\: -f 2 | cut -d\  -f 2`
    dirpath=`repo list | grep "$dirname$" | cut -d\: -f 1`

    gitstr1="http://review.cyanogenmod.com/$gitpath"
    gitstr2="refs/changes/$subpick/$commit/$patch"
    gitstr3="git cherry-pick FETCH_HEAD"

    echo "Cherrypick $commit (patch:$patch subpick:$subpick) status:  *** $status ***"
    echo "subject: '$subject'"
    echo "dirpath: '$dirpath'"
    echo "gitpath: '$gitpath'"

    if [ "$status" != "MERGED" ]
    then 
      if [ "$check" == '0' ]
      then
        echo ""
        pushd $dirpath 1>/dev/null
        echo ""
       	git fetch $gitstr1 $gitstr2 && $gitstr3 || retval=1
        echo ""
        popd 1>/dev/null
      fi
    else
        merged=1
    fi 

    echo ""
    echo "Done with $pick  (retval = $retval; merged = $merged)"
    echo ""
    echo ""
    echo ""

    #rm -f commit.txt
    if [ "$auto" == "0" ]; then read -p "press [enter] to continue..."; fi
}

