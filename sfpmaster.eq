viewpoint native;
define file sfppointa = access sfppoint, set sfppoint:policy_no= sfpmaster:policy_no, 
                                             sfppoint:pol_year= sfpmaster:pol_year 

where sfpmaster:policy_no one of 20536


 and sfpmaster:pol_year one of 2019


list/nobanner/domain="sfpmaster"
  sfpmaster:policy_no 
  sfpmaster:pol_year 
  sfpmaster:end_sequence 

  sfpmaster:trans_date 
  sfpmaster:premium_trans_date 
  sfpmaster:trans_eff 
  sfpmaster:trans_exp
  sfppointa:converted /duplicates
