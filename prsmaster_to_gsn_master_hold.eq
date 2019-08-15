include "startend.inc"
define string l_line[4]=str(prsmaster:line_of_business)+prsmaster:lob_subline 
access gsn_master_hold, set gsn_master_hold:line= l_line


include "prscollect.inc"
and with prsmaster:trans_code < 17

list
/nobanner
/domain="prsmaster"
/nodetail 

prsmaster:line_of_business 
prsmaster:lob_subline 
sfsline:description 
prsmaster:premium 
gsn_master_hold:line /heading="GSN LINE"
gsn_master_hold:premium /heading="GSN Premium"

sorted by l_line 

end of l_line 
box/noblanklines/noheadings 
   prsmaster:line_of_business /align=prsmaster:line_of_business 
   prsmaster:lob_subline/align=prsmaster:lob_subline 
   sfsline:description /align=sfsline:description 
   total[prsmaster:premium]/align=prsmaster:premium 
   gsn_master_hold:line /align=gsn_master_hold:line 
   total[gsn_master_hold:premium]/align=gsn_master_hold:premium 
end box
