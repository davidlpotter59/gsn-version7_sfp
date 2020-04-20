#!/bin/bash
#
# password used in zip file g&gunderWr!ter$

[[ "$#" -ne 2 ]]&&echo "usage: gsn3.sh STARTINGDATE ENDINGDATE "&& exit 9

current_dir=$(pwd)
working_dir=/software/source/cvs_projects/davep/gsn/version7_sfp
data_dir=/data/gsn_debug3

PATH=.
PATH=$PATH:/data/gsn_debug3
PATH=$PATH:/data/csexec
PATH=$PATH:/data/gsn_debug3/lib770_1a
PATH=$PATH:/usr/cqcs/server7.70_1a
PATH=$PATH:/software/shells
PATH=$PATH:/software/source/scips/version730_3a/dm
PATH=$PATH:/software/source/scips/version7/includes/gsn/startend.inc
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


# STARTINGDATE=03012020
# ENDINGDATE=03312020

STARTINGDATE=$1
ENDINGDATE=$2

# STARTINGDATE=$FIRST
# ENDINGDATE=$LAST
echo "STARTINGDATE = " $STARTINGDATE
echo "ENDINGDATE   = " $ENDINGDATE

read me

cd $data_dir

echo "running make for gsn_master_premium"
/software/shells/gsn_master_premium.mk    #make premium file zero so I can see what policies are off when it is done
echo "running make for gsn_master_compare"
/software/shells/gsn_master_compare.mk
/software/shells/gsn_master.mk
/software/shells/scp_add_class_to_iso.mk
/software/shells/cp_add_class_to_iso.mk
/software/shells/isoterritorycodebop.mk
/software/shells/isoterr_lookup_bop.mk

dcheck gsn_master
# dcheck gsn_master_compare
dcheck gsn_master_premium 
echo gsn master recreated
read me
cd $working_dir

echo Check file size now
echo $working_dir
#read me 

$working_dir/gsn3_compile.sh

echo checking compiles press enter
# read me

csbatch -copyright  prsmaster_change_end_sequence $STARTINGDATE$ENDINGDATE
csbatch -copyright  sfpup007_premium_file $STARTINGDATE$ENDINGDATE

csbatch -copyright  sfpup007_gsn_bop $STARTINGDATE$ENDINGDATE
csbatch -copyright  sfpup007_gsn_auto $STARTINGDATE$ENDINGDATE
csbatch -copyright  sfpup007_gsn_cpp $STARTINGDATE$ENDINGDATE
echo Umbrella starts here
read 
csbatch -copyright  sfpup007_gsn_umbrella $STARTINGDATE$ENDINGDATE
echo Umbrella ends here
read 
csbatch -copyright  sfpup007_gsn_contractor $STARTINGDATE$ENDINGDATE
csbatch -copyright  sfpup007_gsn_update_pp_fee $STARTINGDATE$ENDINGDATE

cd /data/gsn_debug3
DATE=`date +%Y%m%d`
TIME=`date +%T|cut -c 1-2,4-5,7-8`


NEWFILE=$DATE"_"$TIME"_"gsn_master.zip
echo $NEWFILE
# read me

zip $NEWFILE gsn_master.*

gsn_master_balance.mk

cd /software/source/cvs_projects/davep/gsn/version7_sfp
#cscomp -nowarn sfpup007_balance_premiums
#csbatch sfpup007_balance_premiums $STARTINGDATE$ENDINGDATE
#cscomp balance_master
# csbatch balance_master  $STARTINGDATE$ENDINGDATE
/software/source/cvs_projects/davep/gsn/version7_sfp/gsn_balance.sh $STARTINGDATE $ENDINGDATE

