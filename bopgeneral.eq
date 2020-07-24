viewpoint native;
define signed ascii number l_limit_10 = bopGENERAL:SIGNS_LIMIT +
                                 bopGENERAL:GLASS_LIMIT + 
                                 bopGENERAL:BURGLARY_LIMIT_ON + 
                                 bopGENERAL:BURGLARY_LIMIT_OFF +
                                 bopGENERAL:MONEY_LIMIT_ON + 
                                 bopGENERAL:MONEY_LIMIT_OFF + 
                                 bopGENERAL:AR_LIMIT + 
                                 bopGENERAL:UTILITY_LIMIT +
                                 bopGENERAL:MECHANICAL_LIMIT + 
                                 bopGENERAL:Loss_INCOME_limit + 
                                 bopGENERAL:SUPPLIES_LIMIT + 
                                 bopGENERAL:POLLUTION_LIMIT +
                                 bopGENERAL:CUSTOMER_PROP_LIMIT + 
                                 bopGENERAL:WATER_BACKUP_LIMIT + 
                                 bopGENERAL:FIRE_LIMIT
define file sfpcurrenta = access sfpcurrent, set sfpcurrent:policy_no= bopgeneral:policy_no 

where bopgeneral:policy_no one of 8648, 24232, 25228, 500000348, 500000356 

and bopgeneral:pol_year = sfpcurrenta:pol_year
and bopgeneral:end_sequence = sfpcurrenta:end_sequence 

list/nobanner/domain="bopgeneral"
  bopgeneral:policy_no 
  bopgeneral:pol_year 
  bopgeneral:end_sequence 
  bopgeneral:prem_no 
  bopgeneral:build_no 
  bopgeneral:line_of_business 
  bopgeneral:building_limit 
  bopgeneral:property_limit 
  --#bopgeneral:glass_limit 
  --#bopgeneral:signs_not_attached_limit 
  --#bopgeneral:signs_limit 
  --#bopgeneral:burglary_limit_on 
  --#bopgeneral:burglary_limit_off 
  --#bopgeneral:money_limit_on 
  --#bopgeneral:money_limit_off 
  --#bopgeneral:loss_income_limit 
  --#bopgeneral:limit_loss_income 
  --#bopgeneral:delete_loss_income 
  --#bopgeneral:ar_limit 
  --#bopgeneral:utility_limit 
  --#bopgeneral:building_code_limit 
  --#bopgeneral:customer_prop_limit 
  --#bopgeneral:mechanical_limit 
  --#bopgeneral:valuable_papers_limit 
  --#bopgeneral:water_backup_limit 
  --#bopgeneral:supplies_limit 
  --#bopgeneral:off_premises_limit 
  --#bopgeneral:debris_removal_limit 
  --#bopgeneral:credit_card_limit
  l_limit_10 

sorted by bopgeneral:policy_no /newlines 
          bopgeneral:prem_no 
          bopgeneral:build_no
