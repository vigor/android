#/bin/bash 
#

[ -d .repo ] || mkdir .repo
pushd .repo

[ -d local_manifests ] || mkdir local_manifests
pushd local_manifests

rm -f local_manifest.xml
wget https://raw.github.com/vigor/android/cm-11.0/local_manifests/local_manifest_hybrid.xml
mv local_manifest_hybrid.xml local_manifest.xml
popd
popd

repo init -b cm-11.0 -u https://github.com/CyanogenMod/android.git

pushd .repo
    sed -i "s/sync-c=\"true\"//g" manifest.xml
popd

repo sync -j8

pushd vendor/cm
./get-prebuilts
popd
