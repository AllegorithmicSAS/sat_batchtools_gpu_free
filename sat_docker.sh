#!/bin/bash
while test $# -gt 0; do
        case "$1" in
             -exe)
                 shift
                 exe=$1
                 shift
                 ;;
             -inputdir)
		 shift
		 inputdir=$1
                 shift
                 ;;
             -outputdir)
		 shift
		 outputdir=$1
                 shift
                 ;;
             -options)
                 shift
                 options=$1
                 shift
                 ;;
             -help)
		 shift
		 echo "
-exe [FILE]                   Full path of a batchtool executable, e.g /opt/sat2019.1.2/sbsbaker
-inputdir [DIR]               Full path of the input directory, e.g /project/meshes/foo
-outputdir [DIR]              Full path of the ouput directory, e.g /project/baked_maps/foo
-options ["STRING"]           All batchtool option (borned by quotation marks), e.g "position-from-mesh --inputs /inputdir/foo.fbx --highdef-mesh /inputdir/bar.fbx --output-path /outputdir"
-user=1000:1000 [USER]        Precise the user who run the docker process and write output files, by default it's the current user 1000:1000
-help                         Display help
"
                 shift
                 ;;
             -user)
		 shift
                 _user=$1;
                 shift
                 ;;
              *)
                 echo "$1 is not a recognized flag!"
                 exit 1;
                ;;
       esac
done;
if [ -z "$_user" ]; then user="1000:1000"; else user=$_user; fi;
if [ -z "$exe" ]; then echo "-exe flags is missing"; exit 1; fi;
if [ -z "$inputdir" ]; then echo "-inputdir flags is missing"; exit 1; fi;
if [ -z "$outputdir" ]; then echo "-outputdir flags is missing"; exit 1; fi;
if [ -z "$options" ]; then echo "-options flags is missing"; exit 1; fi; 
docker run --user $user -it -v `dirname $exe`:/vlm -v $inputdir:/inputdir -v $outputdir:/outputdir sat:latest /tmp/__run_sat.sh `basename $exe` $options
