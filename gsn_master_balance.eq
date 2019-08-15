define string l_sfs[3]="SFS"

define file sfsdefaulta = access sfsdefault, set sfsdefault:sfs_code= l_sfs 
 
define string l_company_id[10]=sfsdefaulta:company_id 

define file sfslinea = access sfsline, set sfsline:company_id         = sfsdefaulta:company_id, 
                                           sfsline:line_of_business   = gsn_master_balance:line_of_business, 
                                           sfsline:lob_subline        = gsn_master_balance:lob_subline 

define file sfslinea_heading = access sfsline, set sfsline:company_id = sfsdefaulta:company_id, 
                                           sfsline:line_of_business   = gsn_master_balance:line_of_business, 
                                           sfsline:lob_subline        = "00" 
define file sfpcurrenta = access sfpcurrent, set sfpcurrent:policy_no= gsn_master_balance:policy_no 

define file sfpnamea    = access sfpname, set sfpname:policy_no= gsn_master_balance:policy_no,
                                              sfpname:pol_year = sfpcurrenta:pol_year, 
                                              sfpname:end_sequence= sfpcurrent:end_sequence 
define file gsn_mastera = access gsn_master, set gsn_master:policy_no= gsn_master_balance:policy_no, generic 

define signed ascii number l_difference = gsn_master_balance:prsmaster_premium - gsn_master_balance:gsn_master_premium

where l_difference <> 0
--where gsn_master_balance:policy_no one of 6702, 14439, 17032, 600005170,
--         600005360, 600005418, 800001019
list
/nobanner
/domain="gsn_master_balance"
/duplicates 

--if l_difference <> 0  then 
box/noblanklines--/noheadings 
--and gsn_master_balance:axis_master_premium = 0 
--then  
{ 
gsn_master_balance:policy_no 
gsn_master_balance:line_of_business 
gsn_master_balance:lob_subline 
gsn_master_balance:pol_year 
--sfslinea_heading:description 
sfslinea:description 
sfslinea:line_type 
sfpnamea:eff_date 
sfpnamea:exp_date   
gsn_master_balance:gsn_master_premium /heading="GSN-Master-Premium"/total 
gsn_master_balance:prsmaster_premium /heading="PRSMASTER-Premium"/total 
l_difference  /heading="Difference"/mask="(ZZZ,ZZZ,ZZZ.99)"/total 
}
xob
sorted by gsn_master_balance:policy_no--/total/newlines 
          gsn_master_balance:line_of_business 
          gsn_master_balance:lob_subline
