#!/bin/bash

#
# gsn_master_update.sh
#

current_dir=`pwd`
PATH=.
PATH=$PATH:/data/gsn_debug3
PATH=$PATH:/data/csexec
PATH=$PATH:/data/gsn_debug3/lib770_1a
PATH=$PATH:/usr/cqcs/server7.70_1a
PATH=$PATH:/software/shells
PATH=$PATH:/software/source/scips/version730_3a/dm
PATH=$PATH:/software/source/scips/version7/includes/gsn
PATH=$PATH:/source/scips/version4/includes
PATH=$PATH:/bin
PATH=$PATH:/usr/bin
PATH=$PATH:/etc/bin
PATH=$PATH:/etc
PATH=$PATH:/usr/local/bin
PATH=$PATH:/sbin

STARTDATE=11012016
ENDDATE=11302016
echo $STARTDATE
echo $ENDDATE
echo $PATH 
read me

cd /data/gsn_debug3/
echo "running make for gsn_master_premium"
/software/shells/gsn_master_premium.mk    #make premium file zero so I can see what policies are off when it is done
echo "running make for gsn_master_compare"
/software/shells/gsn_master_compare.mk

cd /software/source/cvs_projects/davep/gsn/version7_sfp

cscomp -nowarning prsmaster_change_end_sequence.sd
mv prsmaster_change_end_sequence.sb /data/gsn_debug3/lib770_1a

cscomp -nowarn sfpup007_premium_file
mv sfpup007_premium_file.sb /data/gsn_debug3/lib770_1a

cscomp -nowarning sfpup007_auto
mv sfpup007_auto.sb /data/gsn_debug3/lib770_1a

cscomp -nowarning sfpup007_bop
mv sfpup007_bop.sb /data/gsn_debug3/lib770_1a

cscomp -nowarning sfpup007_cpp
mv sfpup007_cpp.sb /data/gsn_debug3/lib770_1a

cscomp -nowarning sfpup007_contractor
mv sfpup007_contractor.sb /data/gsn_debug3/lib770_1a

cscomp -nowarning sfpup007_umbrella
mv sfpup007_umbrella.sb /data/gsn_debug3/lib770_1a

cscomp -nowarning sfpup007_premium_file.sd
mv sfpup007_premium_file.sb /data/gsn_debug3/lib770_1a

cd /data/gsn_debug3/lib770_1a
ls -alF *.sb
read me 

csbatch prsmaster_change_end_sequence $STARTDATE$ENDDATE
csbatch sfpup007_premium_file.sb $STARTDATE$ENDDATE

echo "I am Done Compiling Press enter"
read me

csbatch sfpup007_gsn_bop $STARTDATE$ENDDATE
csbatch sfpup007_gsn_auto $STARTDATE$ENDDATE
csbatch sfpup007_gsn_cpp $STARTDATE$ENDDATE
csbatch sfpup007_gsn_umbrella $STARTDATE$ENDDATE
csbatch sfpup007_gsn_contractor $STARTDATE$ENDDATE
