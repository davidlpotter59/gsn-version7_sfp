#!/bin/bash
current_dir=`pwd`
working_dir=/software/source/cvs_projects/davep/gsn/version7_sfp
data_dir=/data/nwic_debug

PATH=.
PATH=$PATH:/data/nwic_debug
PATH=$PATH:/data/csexec
PATH=$PATH:/data/nwic_debug/lib770_1a
PATH=$PATH:/usr/cqcs/server7.70_1a
PATH=$PATH:/software/shells
PATH=$PATH:/software/source/scips/version730_3a/dm
PATH=$PATH:/software/source/scips/version7/includes/nwic/startend.inc
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

CURRENTDATE=`date +%D`
FIRST=`date -d "$CURRENTDATE -1 month" +0501%Y`
LAST=`date -d "$(date -d "$CURRENTDATE -1 month" +%Y-%m-01) +0 month -1 day" +%m%d%Y`
# LAST=`date -d "$(date -d "$CURRENTDATE -1 month" +%Y-%m-01) +1 month -1 day" +%m%d%Y`

LAST=`date -d "$(date -d "$CURRENTDATE -1 month" +%Y-%m-01) +1 month -1 day" +%m%d%Y`


STARTINGDATE=01012000
ENDINGDATE=10312017
# STARTINGDATE=$FIRST
# ENDINGDATE=$LAST

echo $STARTINGDATE
echo $ENDINGDATE
read me

cd /data/nwic_debug 

/software/shells/gsn_master_premium.mk    #make premium file zero so I can see what policies are off when it is done
/software/shells/gsn_master_compare.mk
/software/shells/gsn_master.mk
/software/shells/scp_add_class_to_iso.mk
/software/shells/cp_add_class_to_iso.mk
/software/shells/isoterritorycodebop.mk
/software/shells/isoterr_lookup_bop.mk

dcheck nwic_master
# dcheck nwic_master_compare
# dcheck nwic_master_premium 
echo gsn master recreated
cd /software/source/cvs_projects/davep/gsn/version7_sfp

echo Check file size now
echo $working_dir
#read me 

$working_dir/nwic3_compile.sh

csbatch -copyright  prsmaster_change_end_sequence $STARTINGDATE$ENDINGDATE
csbatch -copyright  sfpup007_premium_file $STARTINGDATE$ENDINGDATE

csbatch -copyright  sfpup007_gsn_bop $STARTINGDATE$ENDINGDATE
csbatch -copyright  sfpup007_gsn_auto $STARTINGDATE$ENDINGDATE
csbatch -copyright  sfpup007_gsn_cpp $STARTINGDATE$ENDINGDATE
csbatch -copyright  sfpup007_gsn_umbrella $STARTINGDATE$ENDINGDATE
csbatch -copyright  sfpup007_gsn_contractor $STARTINGDATE$ENDINGDATE
csbatch -copyright  sfpup007_gsn_update_pp_fee $STARTINGDATE$ENDINGDATE

