#!/bin/bash

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
    if [ "$check" == '0' ]
    then
        echo "subject: '$subject'"
        echo "dirpath: '$dirpath'"
        echo "gitpath: '$gitpath'"
    fi

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

    if [ "$check" == '0' ]
    then
        echo ""
        echo "Done with $pick  (retval = $retval; merged = $merged)"
        echo ""
        echo ""
        echo ""
    fi

    #rm -f commit.txt
    if [ "$auto" == "0" ]; then read -p "press [enter] to continue..."; fi
}

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

# cherrypicks

# build
getcherrypick 53559

# SuperUser
getcherrypick 53956

# packages/apps/Settings
getcherrypick 53468

# frameworks/av
getcherrypick 53324
getcherrypick 54250
getcherrypick 54217

# frameworks/base
getcherrypick 53544
getcherrypick 53651
getcherrypick 53724
getcherrypick 53695
getcherrypick 54102

# frameworks/native
getcherrypick 52994
getcherrypick 54257

# telephony
getcherrypick 53445
getcherrypick 53528

# hardware/libhardware

# hardware/libhardware_legacy
getcherrypick 53165

# Apps/Camera2
getcherrypick 53595
getcherrypick 53603

# Apps/Dialer
getcherrypick 53302

# Apps/Settings
getcherrypick 53648
getcherrypick 54195

# TelephonyProvider
getcherrypick 53309

# Telephony
getcherrypick 53131
#getcherrypick 53301

# hardware/qcom/media
getcherrypick 54193
getcherrypick 54152
getcherrypick 53434

# hardware/qcom/audio-caf

 
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

# DO NOT REMOVE - required for proper operation of hybrid ion/pmem build
# revert new boot animation
echo ""
echo ">>> revert new boot animation"
pushd vendor/cm
git revert --no-edit b71b47d72b129915327f41653b06edaea5008534 || retval=1
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

exit 1

