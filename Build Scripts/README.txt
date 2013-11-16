Litz's Handy Build Scripts
==========================

copy these scripts to the root of your source folder (eg. ~/Android/cm11.0-rezound) to use

initrepo.sh  -- run this when you first pull down all the source code.

      Please be aware, this will take a very, very long time, and pull down about 

      example : ./initrepo.sh

fixrepo.sh -- run this when you want to wipe out ALL changes and re-sync your source tree.

      example : ./fixrepo.sh

cherrypick.sh -- run this to apply all your local customizations and changes
      add arg "auto" to apply all changes automatically (instead of hitting a key after each one)
	  add arg "check" to check for merged commits only
	  return value of 1 = errors detected
	  return value of 2 = merged commits detected
	  
	  example : ./cherrypick.sh auto
	  
make.sh -- run this to actually build the thing
      add arg "clobber" to do a make clobber, otherwise it just does make
	  
	  example : ./make.sh clobber
	  
	  
Note : these scripts presume your source tree is ~/Android/cm11.0-rezound ... if your source
       is locate elsewhere, you will need to edit/change the scripts appropriately.
	   
Note2 : make.sh utilizes ccache, and utilizes a custom cache folder for this build.
        if you don't want ccache, you will need to comment those lines.