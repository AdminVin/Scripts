# Updating Operation Masters best practice while the old domain controller is online, and seizing the roles (below) should only be done if the old domain controller is not accessible.

### Powershell Method
# Update Server Name
Move-ADDirectoryServerOperationMasterRole -Identity SERVERNAME -OperationMasterRole pdcemulator, ridmaster, infraParentCompanymaster, schemamaster, domainnamingmaster

### Manual Method
## Step 1
# Active Directory Sites & Services > Navigate to the old DC’s NTDS Settings, and Properties > Verify that Global Catalog is checked off.

## Step 2 - FSMO (RID, PDC, and Infrastructure)
# Login to new DC > Active Directory Users and Computers > Right Click Domain > Operation Masters
# Navigate to each tab, and change over the server to the new DC

## Step 3 - FSMO (Schema Master)
# CMD > regsvr32 schmmgmt.dll
# CMD > MMC > Add Active Directory Schema > Right Click on "Active Directory Schema" > Operations Masters
# Change to new DC

####################################################################################################################################################################
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
seize infrastructure master
quit