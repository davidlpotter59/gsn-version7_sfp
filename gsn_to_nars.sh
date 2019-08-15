#!/bin/bash
current_dir=`pwd`
working_dir=/home/$LOGNAME
data_dir=/data/gsn

PATH=.
PATH=$PATH:/data/gsn
PATH=$PATH:/data/csexec
PATH=$PATH:/data/gsn/lib770_1a
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

STARTINGDATE=01012016
ENDINGDATE=`date +%m%d%Y`

cd /data/gsn 

# echo "running make for gsn_master_premium"
/software/shells/gsn_master_premium.mk    #make premium file zero so I can see what policies are off when it is done
# echo "running make for gsn_master_compare"
/software/shells/gsn_master_compare.mk
/software/shells/gsn_master.mk

# dcheck gsn_master
# dcheck gsn_master_compare
# dcheck gsn_master_premium 

cd /home/$LOGNAME

csbatch -copyright  prsmaster_change_end_sequence $STARTINGDATE$ENDINGDATE
csbatch -copyright  sfpup007_premium_file.sb $STARTINGDATE$ENDINGDATE

csbatch -copyright  sfpup007_gsn_bop $STARTINGDATE$ENDINGDATE
csbatch -copyright  sfpup007_gsn_auto $STARTINGDATE$ENDINGDATE
csbatch -copyright  sfpup007_gsn_cpp $STARTINGDATE$ENDINGDATE
csbatch -copyright  sfpup007_gsn_umbrella $STARTINGDATE$ENDINGDATE
csbatch -copyright  sfpup007_gsn_contractor $STARTINGDATE$ENDINGDATE
csbatch -copyright  sfpup007_gsn_update_pp_fee $STARTINGDATE$ENDINGDATE

cd /data/gsn
DATE=`date +%Y%m%d`
TIME=`date +%T|cut -c 1-2,4-5,7-8`


