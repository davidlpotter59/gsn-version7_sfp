#!/bin/bash
current_dir=`pwd`
working_dir=/software/source/cvs_projects/davep/gsn/version7_sfp
data_dir=/data/gsn_debug3

PATH=.
PATH=$PATH:/data/gsn_debug3
PATH=$PATH:/data/csexec
PATH=$PATH:/data/gsn_debug3/lib770_1a
PATH=$PATH:/usr/cqcs/server7.70_1a
PATH=$PATH:/software/shells
PATH=$PATH:/source/scips/version730/dm
PATH=$PATH:/source/scips/version7/includes
PATH=$PATH:/source/scips/version4/includes
PATH=$PATH:/bin
PATH=$PATH:/usr/bin
PATH=$PATH:/etc/bin
PATH=$PATH:/etc
PATH=$PATH:/usr/local/bin
PATH=$PATH:/sbin
export PATH

VCQ_DBPATH=$data_dir

STARTINGDATE=08012016
ENDINGDATE=08312016

echo $STARTINGDATE
echo $ENDINGDATE
read me

cd /data/gsn_debug3 

echo "running make for gsn_master_premium"
/software/shells/gsn_master_premium.mk    #make premium file zero so I can see what policies are off when it is done
echo "running make for gsn_master_compare"
/software/shells/gsn_master_compare.mk
/software/shells/gsn_master.mk

dcheck gsn_master
dcheck gsn_master_compare
dcheck gsn_master_premium 

cd /software/source/cvs_projects/davep/gsn/version7_sfp

echo Check file size now
echo $working_dir
read me 

$working_dir/gsn3_compile.sh

csbatch -copyright  prsmaster_change_end_sequence $STARTINGDATE$ENDINGDATE
csbatch -copyright  sfpup007_premium_file.sb $STARTINGDATE$ENDINGDATE

csbatch -copyright  sfpup007_gsn_bop $STARTINGDATE$ENDINGDATE
csbatch -copyright  sfpup007_gsn_auto $STARTINGDATE$ENDINGDATE
csbatch -copyright  sfpup007_gsn_cpp $STARTINGDATE$ENDINGDATE
csbatch -copyright  sfpup007_gsn_umbrella $STARTINGDATE$ENDINGDATE
csbatch -copyright  sfpup007_gsn_contractor $STARTINGDATE$ENDINGDATE
csbatch -copyright  sfpup007_gsn_update_pp_fee $STARTINGDATE$ENDINGDATE

cd /data/gsn_debug3
DATE=`date +%Y%m%d`
TIME=`date +%T|cut -c 1-2,4-5,7-8`


NEWFILE=$DATE"_"$TIME"_"gsn_master.zip
echo $NEWFILE
read me

zip $NEWFILE gsn_master.*

gsn_master_balance.mk

cd /software/source/cvs_projects/davep/gsn/version7_sfp
cscomp -nowarn sfpup007_balance_premiums
csbatch sfpup007_balance_premiums $STARTINGDATE$ENDINGDATE
# cscomp balance_master
# csbatch balance_master  $STARTINGDATE$ENDINGDATE
# ./gsn_balance.sh
