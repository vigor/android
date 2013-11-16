#/bin/bash 
#

# cd to our source root
cd ~/Android/cm11.0-rezound

# init the repo
repo init -b cm-11.0 -u git://github.com/vigor/android.git

# initial source pull.  This will take a very, very long time.
repo sync -j16

# get the prebuilts files
pushd vendor/cm
    ./get-prebuilts
popd


