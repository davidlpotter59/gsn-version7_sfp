define wdate l_starting_date1 = dateadd(01.01.0000,month(todaysdate)-2,year(todaysdate))
define wdate l_ending_date1   = dateadd(l_starting_date1,1)-1

define wdate l_starting_date = parameter/prompt="Enter Starting Date " default l_starting_date1 
define wdate l_ending_date = parameter/prompt="Enter Ending Date " default l_ending_date1 

define string l_sfs = "SFS"
define file sfsdefaulta = access sfsdefault, set sfsdefault:sfs_code= l_sfs 

define file sfsline_gsn = access line, set line:line_of_business= gsn_master:line_of_business, 
                                               line:lob_subline= gsn_master:lob_subline, exact 

define file sfsstmta = access sfsstmt, set sfsstmt:company_id= sfsdefaulta:company_id, 
                                           sfsstmt:stmt_lob= sfsline_gsn:stmt_lob 

where gsn_master:premium <> 0 and  -- was 0
      ((gsn_master:trans_date < l_starting_date and 
       gsn_master:trans_eff_date => l_starting_date and 
       gsn_master:trans_eff_date <= l_ending_date) or
      (gsn_master:trans_date => l_starting_date and 
       gsn_master:trans_date <= l_ending_date and 
       gsn_master:trans_eff_date <= l_ending_date)) 

list
/nobanner
/domain="gsn_master"
/nodetail 

sfsline_gsn:stmt_lob 
gsn_master:line_of_business /column=20
sfsline_gsn:description /column=25
gsn_master:premium /total/mask="(ZZZ,ZZZ,ZZZ.99)"/column=70

sorted by sfsline_gsn:stmt_lob /newlines 
          gsn_master:line_of_business 

top of sfsline_gsn:stmt_lob
box/noblanklines/noheadings 
   sfsline_gsn:stmt_lob 
   sfsstmta:description 
end box

end of gsn_master:line_of_business 
box/noblanklines /noheadings 
    gsn_master:line_of_business /column=20
    sfsline_gsn:description /column=25
    total[gsn_master:premium]/mask="(ZZZ,ZZZ,ZZZ.99)"/align=gsn_master:premium 
end box

end of sfsline_gsn:stmt_lob 
box/noblanklines /noheadings 
    trim(sfsstmta:description) + " Total" /column=20
    total[gsn_master:premium]/mask="(ZZZ,ZZZ,ZZZ.99)"/align=gsn_master:premium 
end box
