#!/bin/bash
current_dir=`pwd`
PATH=.:/data/gsn_debug3:/data/csexec:/data/gsn_debug3/lib770_1a:/usr/cqcs/server7.70_1a:/software/shells:/source/scips/version730/dm:/source/scips/version7/includes:/source/scips/version4/includes:/bin:/usr/bin:/etc/bin:/etc:/usr/local/bin:/sbin

STARTINGDATE=11012018
ENDINGDATE=11302018

echo $STARTINGDATE
echo $ENDINGDATE
read me 

cd /software/source/cvs_projects/davep/gsn/version7_sfp
cd /data/gsn_debug3/
echo "running make for gsn_master_premium"
/software/shells/gsn_master_premium.mk    #make premium file zero so I can see what policies are off when it is done
echo "running make for gsn_master_compare"
/software/shells/gsn_master_compare.mk

cd /software/source/cvs_projects/davep/gsn/version7_sfp

csbatch prsmaster_change_end_sequence $STARTINGDATE$ENDINGDATE
csbatch sfpup007_premium_file.sb $STARTINGDATE$ENDINGDATE

csbatch sfpup007_gsn_bop $STARTINGDATE$ENDINGDATE
csbatch sfpup007_gsn_auto $STARTINGDATE$ENDINGDATE
csbatch sfpup007_gsn_cpp $STARTINGDATE$ENDINGDATE
csbatch sfpup007_gsn_umbrella $STARTINGDATE$ENDINGDATE
csbatch sfpup007_gsn_contractor $STARTINGDATE$ENDINGDATE
csbatch sfpup007_gsn_update_pp_fee $STARTINGDATE$ENDINGDATE
