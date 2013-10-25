#!/bin/bash

PATH=~/bin:$PATH
DIR=$(pwd)

cd $DIR
repo sync -j10
cd $DIR/packages/apps/CMUpdater
    git fetch https://github.com/IAmTheOneTheyCallNeo/android_packages_apps_CMUpdater.git cm-10.2 && git cherry-pick 61c85d22e302056c4dcaac06458a818a81d9a02c
cd $DIR/packages/apps/Settings
    git fetch https://github.com/IAmTheOneTheyCallNeo/android_packages_apps_Settings.git tachyon && git cherry-pick c9c365991900f32c8bf9b95f81a75f295b7227f2
    git cherry-pick aa722c94ce5ec15c34fd5765604613310bd627c3
    git cherry-pick 061ffdfcf2c76fa47423d5867f74c649a75023a2
cd $DIR/frameworks/base
    git fetch https://github.com/IAmTheOneTheyCallNeo/android_frameworks_base.git tachyon && git cherry-pick a86572d5bc46540b10f0f0d4edfad82e0f9e39be
    git cherry-pick f6f4e51d741d44b7752a2a1a0d2d2f9338e54851
    git cherry-pick 67f440121d9e31746f551c43a93606a4233a4286
    git cherry-pick 40d69243eea2f7d5145ba1424e78c4c950c05b64
cd $DIR/packages/apps/Mms
    git fetch https://github.com/IAmTheOneTheyCallNeo/android_packages_apps_Mms.git cm-10.2 && git cherry-pick 359944ed10f3eb6b9a034102ffe42b1ea5428a8a
    git cherry-pick bfcea8b95fec0142f6da62e68da1cf794eb348e1
cd $DIR/packages/apps/Trebuchet
    git fetch https://github.com/IAmTheOneTheyCallNeo/android_packages_apps_Trebuchet tachyon && git cherry-pick b4d122c8c52467e602212bc7ea6161abed3252f3
cd $DIR
PRODUCT_VERSION_MAJOR=10
PRODUCT_VERSION_MINOR=2
DATE=$(date -u +%Y%m%d)
CM_BUILDTYPE=UNOFFICIAL
PRODUCT=vigor
VERSION="cm-$PRODUCT_VERSION_MAJOR.$PRODUCT_VERSION_MINOR-"$DATE"-$CM_BUILDTYPE-$PRODUCT"
SITEHTML="index.html"
TEMPHTML="temp"
FILE="$VERSION.zip"
FTPTARGETDIR="roms/iamtheonetheycallneo/cm10.2/vigor/"
USERNAME=usernamegoeshere
PASSWORD="passwordgoeshere"
SERVER=theservergoeshere
KERNELGOD=snuzzo
cd $DIR
./vendor/cm/get-prebuilts
. build/envsetup.sh
time brunch vigor -j7
echo $FILE
echo "From"
ZIPDIR="out/target/product/$PRODUCT"
echo $DIR/$ZIPDIR
cd $DIR/$ZIPDIR
md5sum $VERSION.zip > $VERSION.md5
echo "MD5 is .."
cat $VERSION.md5
wget http://$SERVER/$KERNELGOD/$FTPTARGETDIR/api
mv -f api api.orig
cat api.orig | head -n -3 > api
buildname="`ls -t *.md5 | head -n 1 | sed 's/\.md5//g'`"
buildmd5="$buildname.md5"
md5sum="`cat $buildname.md5 | cut -d\  -f 1`"
buildzip="$buildname.zip"
oldstamp="`cat api | grep timestamp | tail -n 1 | cut -d\: -f 2 | sed 's/\"//g' | sed 's/,//g' | sed 's/ //g' | head -n 1 | sed 's/[^0-9]*//g'`"
newstamp=$(($oldstamp + 1))
echo "    {" >> api
echo "    \"url\": \"http://vp-zp.com/snuzzo/roms/iamtheonetheycallneo/cm10.2/vigor/$buildzip\"," >> api
echo "    \"timestamp\": \"$newstamp\"," >> api
echo "    \"md5sum\": \"$md5sum\"," >> api
echo "    \"api_level\": \"18\"," >> api
echo "    \"filename\": \"$buildname.zip\"," >> api
echo "    \"changes\": \"http://vp-zp.com/snuzzo/roms/iamtheonetheycallneo/changes.txt\"," >> api
echo "    \"channel\": \"nightly\"" >> api
echo "    }," >> api
echo "  ]," >> api
echo "  \"error\": null" >> api
echo "}" >> api
rm -f api.orig
curl -T $FILE ftp://$SERVER/$FTPTARGETDIR --user $USERNAME:$PASSWORD
curl -T boot.img ftp://$SERVER/$FTPTARGETDIR --user $USERNAME:$PASSWORD
curl -T api ftp://$SERVER/$FTPTARGETDIR --user $USERNAME:$PASSWORD
curl -T $VERSION.md5 ftp://$SERVER/$FTPTARGETDIR --user $USERNAME:$PASSWORD
cd ~/$DIR
make clobber
echo
echo "#------- COMPLETED -------#"
echo "Press any key to continue... or [X/x] to Exit..."
read -s -n 1 any_key
if [ "$any_key" = x ] || [ "$any_key" = X ]
then
exit
fi

