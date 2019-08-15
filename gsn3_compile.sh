PATH=.
PATH=$PATH:/data/gsn_debug3
PATH=$PATH:/data/csexec
PATH=$PATH:/data/gsn_debug3/lib770_1a
PATH=$PATH:/usr/cqcs/server7.70_1a
PATH=$PATH:/software/shells
PATH=$PATH:/software/source/scips/version730_3a/dm
PATH=$PATH:/source/scips/version7/includes
PATH=$PATH:/source/scips/version4/includes
PATH=$PATH:/software/source/scips/version7/includes/gsn
PATH=$PATH:/bin
PATH=$PATH:/usr/bin
PATH=$PATH:/etc/bin
PATH=$PATH:/etc
PATH=$PATH:/usr/local/bin
PATH=$PATH:/sbin

cscomp -nowarn sfpup007_gsn_bop 
cscomp -nowarn sfpup007_gsn_auto 
cscomp -nowarn sfpup007_gsn_cpp 
cscomp -nowarn sfpup007_gsn_umbrella 
cscomp -nowarn sfpup007_gsn_contractor 
cscomp -nowarn sfpup007_gsn_update_pp_fee 
cscomp -nowarn prsmaster_change_end_sequence
cscomp -nowarn sfpup007_premium_file
cscomp -nowarn balance_master

mv sfpup007_gsn_bop.sb /data/gsn_debug3/lib770_1a
mv sfpup007_gsn_auto.sb /data/gsn_debug3/lib770_1a
mv sfpup007_gsn_cpp.sb /data/gsn_debug3/lib770_1a
mv sfpup007_gsn_umbrella.sb /data/gsn_debug3/lib770_1a
mv sfpup007_gsn_contractor.sb /data/gsn_debug3/lib770_1a
mv sfpup007_gsn_update_pp_fee.sb /data/gsn_debug3/lib770_1a
mv sfpup007_premium_file.sb /data/gsn_debug3/lib770_1a
mv prsmaster_change_end_sequence.sb /data/gsn_debug3/lib770_1a
mv balance_master.sb /data/gsn_debug3/lib770_1a
