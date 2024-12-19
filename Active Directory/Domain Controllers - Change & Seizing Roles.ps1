#################################################################################################
# Updating Operation Masters best practice while the old domain controller is online            #
#                                                                                               #
# Seizing the roles (below) should only be done if the old domain controller is not accessible. #
#                                                                                               #
#################################################################################################

#########################################################
# Old Domain Controller/Server is ONLINE and ACCESSIBLE #
#########################################################

### Powershell Method
# Login to NEW Domain Controller
Move-ADDirectoryServerOperationMasterRole -Identity "NEW_ServerName.DOMAIN.local" -OperationMasterRole SchemaMaster, DomainNamingMaster, PDCEmulator, RIDMaster, InfrastructureMaster


### Command Prompt Method
## Step 1 - Global Catalog
# Login to new DC > Open 'Active Directory Sites & Services'
# Navigate to the old domain controller's 'NTDS Settings' > Right click and select 'Properties' > Uncheck 'Global Catalog' > Select Ok

## Step 2 - FSMO: RID, PDC, and Infrastructure
# Login to new DC > Open 'Active Directory Users and Computers' > Right click and select 'Properties' > Select 'Operation Masters'
# Navigate to each tab and change over to the new DC.

## Step 3 - FSMO: Schema Master
# Open CMD (ad administrator) > Run "regsvr32 schmmgmt.dll" > Run "MMC"
# MMC Window > File > Add "Active Directory Schema" > Right Click on "Active Directory Schema" > Select "Operations Masters" > Change to the new DC.

## Step 4 - FSMO: Operations Master
# Open "Active Directory Domains and Trusts" > Right click on "Active Directory Domains and Trusts" > Select "Operations Master" > Change to the new DC.



#############################################################################
# Old Domain Controller/Server is OFFLINE and NOT ACCESSIBLE                #
#                                                                           #
# Note: After seizing FSMO Roles, remember to cleanup AD sites and Services #
#############################################################################

cmd
ntdsutil
roles
connections
connect to server NEW_ServerName.DOMAIN.local
quit
seize schema master
seize naming master
seize RID master
seize pdc
seize infrastructure master
quit