### This will allow you to seize all Operation Masters to a new DC (when the old DC is no longer accessible)
# After seizing the FSMO roles, remember to clean up AD Sites and Services, and DHCP Servers
cmd
ntdsutil
roles
connections
connect to server SERVERNAME
quit
seize schema master
seize naming master
seize RID master
seize pdc
seize infraParentCompany master
quit


####################################################################################################################################################################
# After taking over all roles, verify all roles were migrated successfully
CMD > "netdom query fsmo" (without quotes)