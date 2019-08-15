. scips_v730 gsn_debug3
# always run this after the updates to gsn_master
# it tries to correct many issues with premium by sub line

# also, you will want to unzip the most current zip not the
# one listed below.

# It might take a couple of runs to make this work - in the case of
# multiple runs do not unzip any files.  that would just wipe out
# any updates that were done to the gsn_master file

STARTINGDATE=02012019
ENDINGDATE=02282019

STARTINGDATE=$1
ENDINGDATE=$2

echo $STARTINGDATE
echo $ENDINGDATE
read me


cd /data/gsn_debug3

# unzip -o 20160427_143621_gsn_master.zip
/software/shells/gsn_master_balance.mk
dcheck gsn_master_balance
read me 

cd /software/source/cvs_projects/davep/gsn/version7_sfp
cscomp -nowarn balance_master

cqcsfind prsmaster.dat
cqcsfind gsn_master.dat
cqcsfind gsn_master_balance.dat

# dcheck `cqcsfind gsn_master_balance.dat`

# setting run mode on this execution to 1
# process the update

# cscomp balance_master
mv balance_master.sb /data/gsn_debug3/lib730_3a 

cqcsfind gsn_master_balance.dat
cqcsfind gsn_master_balance.idx
# read me

csbatch balance_master $STARTINGDATE$ENDINGDATE 1

# now run to update the buckets to see what the 
# differences are after the update
# setting run mode to 0 (do not update)

cd /data/gsn_debug3

/software/shells/gsn_master_balance.mk

cd /software/source/cvs_projects/davep/gsn/version7_sfp

csbatch balance_master $STARTINGDATE$ENDINGDATE 0
