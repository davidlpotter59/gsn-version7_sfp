include "startend.inc"

include "prscollect.inc"
and with prsmaster:trans_code < 17
and with prsmaster:policy_no one of 13640, 20536

list
/nobanner
/domain="prsmaster"

prsmaster:policy_no 
prsmaster:sub_code 
prsmaster:line_of_business 
prsmaster:lob_subline 
sfsline:description 
prsmaster:trans_date 
prsmaster:trans_eff
prsmaster:pol_year 
prsmaster:end_sequence 
prsmaster:premium 

sorted by prsmaster:policy_no
