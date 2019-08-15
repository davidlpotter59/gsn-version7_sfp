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
PATH=$PATH:/software/source/scips/version730/dm
PATH=$PATH:/software/source/scips/version730_3a/dm/
PATH=$PATH:/software/source/scips/version7/includes
PATH=$PATH:/software/source/scips/version4/includes
PATH=$PATH:/bin
PATH=$PATH:/usr/bin
PATH=$PATH:/etc/bin
PATH=$PATH:/etc
PATH=$PATH:/usr/local/bin
PATH=$PATH:/sbin

VCQ_DBPATH=$data_dir

STARTINGDATE=04012017
ENDINGDATE=04302017

echo $STARTINGDATE
echo $ENDINGDATE
read me

cd /data/gsn_debug3

cp bkup_gsn_master.dat gsn_master.dat
cp bkup_gsn_master.idx gsn_master.idx

cd /software/source/cvs_projects/davep/gsn/version7_sfp

cscomp sfpup007_balance_premiums

csbatch sfpup007_balance_premiums $STARTINGDATE$ENDINGDATE
