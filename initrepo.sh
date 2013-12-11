#/bin/bash 
#

[ -d .repo ] || mkdir .repo
pushd .repo

[ -d local_manifests ] || mkdir local_manifests
pushd local_manifests

rm -f local_manifest.xml
wget https://raw.github.com/vigor/android/cm-10.2/local_manifests/local_manifest.xml

popd
popd

repo init -b cm-10.2 -u git://github.com/CyanogenMod/android.git

repo sync -j16

pushd vendor/cm
./get-prebuilts
popd
