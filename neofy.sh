!/bin/bash

#GCC Freedom

echo
echo
echo This will modify your build environment heavily with the following changes:
echo GCC arm-linux-androideabi for CM rom changed to SaberMods AOSP Optimized 4.8 GCC
echo GCC arm-eabi for kernel changed to SaberMods AOSP Optimized 4.8 GCC
echo TARGET Arm CFlags for building changed to -O3 Compiler Flags for Optimal Performance
echo Strict Aliasing enabled for TARGET arm and TARGET thumb CFlags at the highest level 3
echo Additional non -Os compiler flags added to the build source for extra system performance
echo Cherry picks all 21 strict aliasing commits to source - make sure they all took correctly
echo This will take some time so be patient...
echo
echo

DIR=$(pwd)

cd $DIR/prebuilts/gcc/linux-x86/arm/
git clone -b sm-kk-mr1 https://github.com/SaberMod/android_prebuilts_gcc_linux-x86_arm_sabermod-arm-linux-androideabi-4.8 arm-linux-androideabi-4.8
git clone -b sm-kk-mr1 https://github.com/SaberMod/android_prebuilts_gcc_linux-x86_arm_sabermod-arm-eabi-4.8 arm-eabi-4.8

cd $DIR/build/
git fetch https://github.com/IAmTheOneTheyCallNeo/android_build tachyon-2.0 && git cherry-pick 2c1e134c8a97cbc02adf7888327a7a276a7c4846

cd $DIR/external/oprofile/
git fetch https://github.com/IAmTheOneTheyCallNeo/android_external_oprofile tachyon-2.0 && git cherry-pick d2564470a30a2e643fb61714a5e8590a6e8cdc2b

cd $DIR/external/e2fsprogs/
git fetch https://github.com/IAmTheOneTheyCallNeo/android_external_e2fsprogs tachyon-2.0 && git cherry-pick 75088ae111d6c09fb1a5fdf2eccacbeb54d1b76c

cd $DIR/bionic/
git fetch https://github.com/IAmTheOneTheyCallNeo/android_bionic tachyon-2.0 && git cherry-pick f071fb6eef62cc4928d0521460599fab04b9969f

cd $DIR/dalvik/
git fetch https://github.com/IAmTheOneTheyCallNeo/android_dalvik tachyon-2.0 && git cherry-pick fe1966fabfc44b18a14850d04f97512a2d602843

cd $DIR/frameworks/base/
git fetch https://github.com/IAmTheOneTheyCallNeo/android_frameworks_base tachyon-2.0 && git cherry-pick 238cd26ce6929c35c761e35351f3f4f0b7457938

cd $DIR/external/stlport/
git fetch https://github.com/IAmTheOneTheyCallNeo/android_external_stlport tachyon-2.0 && git cherry-pick f164acdbbbdfef50bf0aa374607b56d243a18938

cd $DIR/external/clang/
git fetch https://github.com/IAmTheOneTheyCallNeo/android_external_clang tachyon-2.0 && git cherry-pick e41d99927139ba9afd3c76ebbaac9cd582396424

cd $DIR/frameworks/av/
git fetch https://github.com/IAmTheOneTheyCallNeo/android_frameworks_av tachyon-2.0 && git cherry-pick 476a38107cf594454cfdedee3343edb93c348733

cd $DIR/external/dnsmasq/
git fetch https://github.com/IAmTheOneTheyCallNeo/android_external_dnsmasq tachyon-2.0 && git cherry-pick 50676d05317cc2b0cdbe6f24ddb991c53483fd57

cd $DIR/frameworks/compile/slang/
git fetch https://github.com/IAmTheOneTheyCallNeo/android_frameworks_compile_slang tachyon-2.0 && git cherry-pick 01cd0efe7e9da2e4b91ac76f3da0281f9245b30b

cd $DIR/external/iputils/
git fetch https://github.com/IAmTheOneTheyCallNeo/android_external_iputils tachyon-2.0 && git cherry-pick 87c334c3fb0fac0ee92be50c24563f612b70973d

cd $DIR/external/openssh/
git fetch https://github.com/IAmTheOneTheyCallNeo/android_external_openssh tachyon-2.0 && git cherry-pick 7a152c43552233bbf611c206c611e62a39b17656

cd $DIR/frameworks/rs/
git fetch https://github.com/IAmTheOneTheyCallNeo/android_frameworks_rs tachyon-2.0 && git cherry-pick c54f191fddec7089b8c8eb1b66d38a10f75c4eb5

cd $DIR/frameworks/native/
git fetch https://github.com/IAmTheOneTheyCallNeo/android_frameworks_native tachyon-2.0 && git cherry-pick 9570c494e5b18afd670542d90b8c85cb8e347aa4

cd $DIR/device/generic/goldfish/
git fetch https://github.com/IAmTheOneTheyCallNeo/android_device_generic_goldfish tachyon-2.0 && git cherry-pick fa6c45a973752922be36de28cfe526e7b8a3af03

cd $DIR/libcore/
git fetch https://github.com/IAmTheOneTheyCallNeo/android_libcore tachyon-2.0 && git cherry-pick c8e1d82487c016b3e13b1d3b7d1f3fef84784219

cd $DIR/frameworks/opt/net/voip/
git fetch https://github.com/IAmTheOneTheyCallNeo/android_frameworks_opt_net_voip tachyon-2.0 && git cherry-pick 9c2ce1fc56ad08ee0b3c8279d257b5c5ded7be32

cd $DIR/frameworks/wilhelm/
git fetch https://github.com/IAmTheOneTheyCallNeo/android_frameworks_wilhelm tachyon-2.0 && git cherry-pick ef9ec68e2011b9f4290c27f90082ddf218866625

cd $DIR/hardware/qcom/gps/
git fetch https://github.com/IAmTheOneTheyCallNeo/android_hardware_qcom_gps tachyon-2.0 && git cherry-pick 4bf8441c46cddcdc9f604d1a012166e05530744c

cd $DIR/external/lsof/
git fetch https://github.com/IAmTheOneTheyCallNeo/android_external_lsof tachyon-2.0 && git cherry-pick 44e30c310ed2f0c0ac4e8488fd37d51f91f933bf

cd $DIR/external/chromium/
git fetch https://github.com/IAmTheOneTheyCallNeo/android_external_chromium tachyon-2.0 && git cherry-pick 6dae14a200d444fc7e834bc2369437d37851d376

cd $DIR/frameworks/ex/
git fetch https://github.com/IAmTheOneTheyCallNeo/android_frameworks_ex tachyon-2.0 && git cherry-pick a59bcbaa97ad8d62bd2e5d06d25f411c4aa06253

cd $DIR/
./vendor/cm/get-prebuilts
. build/envsetup.sh

echo
echo
echo DONE
echo Please visit https://github.com/IAmTheOneTheyCallNeo/android_build/commit/2c1e134c8a97cbc02adf7888327a7a276a7c4846
echo to get instructions on how to change the custom toolchain should you decide you want to experiment a bit
echo
echo
