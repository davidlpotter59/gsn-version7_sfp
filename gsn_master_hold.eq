-- include "startend.inc"
define wdate l_starting_date1 = dateadd(01.01.0000,month(todaysdate)-2,year(todaysdate))
define wdate l_ending_date1   = dateadd(l_starting_date1,1)-1

define wdate l_starting_date = parameter/prompt="Enter Starting Date " default l_starting_date1 
define wdate l_ending_date = parameter/prompt="Enter Ending Date " default l_ending_date1 

define file sfsline_alias = access sfsline,
                               set sfsline:company_id       = "GGUND     ",
                                   sfsline:line_of_business = gsn_master:line_of_business,
                                   sfsline:lob_subline      = "00", exact 
 

define string l_company_id[10]="GGUND     "
          
define string l_writing_company = "gsn"
define string l_company_code = "37100"
define file prsmastera = access prsmaster, set prsmaster:company_id = l_company_id, 
                                               prsmaster:policy_no= gsn_master:policy_no, generic 

define unsigned ascii number l_payment_plan = if prsmastera:trans_code < 17 and prsmastera:payment_plan <> 0 then prsmastera:payment_plan 
define string l_policy_type_indicator = if gsn_master:policy_eff_date < 01.25.2017 and 
   gsn_master:policy_indicator = "RENEWAL" then "NEW"
   else trun(gsn_master:policy_indicator)
define signed ascii number l_comm_to_gsn = (gsn_master:premium * (gsn_master:agency_commission * 0.01))

/* january 10 2019 new policy number formatting */
define string l_suffix = str(year(gsn_master:eff_date))
define string l_years = str(year(l_ending_date) - year(gsn_master:eff_date)+1)

--define string l_str_policy_no = (trun(sfsline_alias:alpha) + trun(str(gsn_master:policy_no))) + " - " +  trun(l_suffix) + "-" + trun(l_years)
define string l_str_policy_no = (trun(l_company_code) + "-" + trun(str(gsn_master:policy_no))) + "-" +  trun(l_suffix) + "-" + trun(l_years)


define wdate l_accounting_date = if gsn_master:accounting_date <> l_ending_date then l_ending_date else gsn_master:accounting_date 


define string l_str_prior_pol_num = if val(gsn_master:policy_suffix) >= 1 then
    trun(sfsline_alias:alpha)+ trun(str(gsn_master:prior_policy_number)) else "0"


define wdate l_prior_eff_date = if val(gsn_master:policy_suffix) >= 1 then
    gsn_master:Prior_policy_Number_Eff_Date/heading="Prior_Policy_Number_Eff_Dt" else 01.01.1900

define file sfslinea = access sfsline, set sfsline:company_id    = l_company_id, 
                                           sfsline:line_of_business=  gsn_master:line_of_business,
                                           sfsline:lob_subline= "00"

define file sfslineab = access sfsline, set sfsline:company_id    = l_company_id, 
                                           sfsline:line_of_business=  gsn_master:line_of_business,
                                           sfsline:lob_subline= gsn_master:subline_code 

define file sfsline2a = access sfsline2, set sfsline2:company_id= sfslinea:company_id, 
                                             sfsline2:line_of_business= sfslinea:line_of_business, 
                                             sfsline2:lob_subline= gsn_master:subline_code  

define string l_line = str(gsn_master:line_of_business) + trun(gsn_master:subline_code)

where gsn_master:premium <> 0 and  -- was 0
      ((gsn_master:trans_date < l_starting_date and 
       gsn_master:trans_eff_date => l_starting_date and 
       gsn_master:trans_eff_date <= l_ending_date) or
      (gsn_master:trans_date => l_starting_date and 
       gsn_master:trans_date <= l_ending_date and 
       gsn_master:trans_eff_date <= l_ending_date)) 
     and gsn_master:trans_date => 11.20.2018 and 
         gsn_master:trans_eff_date => 11.20.2018

--and with policy_no one of 2300
--and with line_of_business one of 8
--and with lob_subline one of "81"

 --  and with policy_no one of 572
--and with policy_no one of 4583000024, 120001053
--and gsn_master:limit[24] <> 0
list 
/domain="gsn_master" 
/nodetail 
/hold="gsn_master_hold"
 
sorted by l_Line

end of l_line
l_line/keyelement=1/name="line"
total[premium]/mask="999999999.99-"/name="premium"
