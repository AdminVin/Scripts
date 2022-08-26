# Create Security Groups (OU Scoped)
# 
$ou = “OU=Groups,OU=Company,OU=ParentCompany,DC=DOMAIN,DC=local”

NEW-ADGroup -Name "Accounting & Finance - Read” –groupscope Global –path $ou
NEW-ADGroup -Name "Accounting & Finance - Write” –groupscope Global –path $ou
#
NEW-ADGroup -Name "Activities - Read” –groupscope Global –path $ou
NEW-ADGroup -Name "Activities - Write” –groupscope Global –path $ou
#
NEW-ADGroup -Name "Administration - Read” –groupscope Global –path $ou
NEW-ADGroup -Name "Administration - Write” –groupscope Global –path $ou
#
NEW-ADGroup -Name "Business Development - Read” –groupscope Global –path $ou
NEW-ADGroup -Name "Business Development - Write” –groupscope Global –path $ou
#
NEW-ADGroup -Name "Business Office - Read” –groupscope Global –path $ou
NEW-ADGroup -Name "Business Office - Write” –groupscope Global –path $ou
#
NEW-ADGroup -Name "Clinical - Read” –groupscope Global –path $ou
NEW-ADGroup -Name "Clinical - Write” –groupscope Global –path $ou
#
NEW-ADGroup -Name "Contracts - Read” –groupscope Global –path $ou
NEW-ADGroup -Name "Contracts - Write” –groupscope Global –path $ou
#
NEW-ADGroup -Name "Dietary - Read” –groupscope Global –path $ou
NEW-ADGroup -Name "Dietary - Write” –groupscope Global –path $ou
#
NEW-ADGroup -Name "Human Resources - Read” –groupscope Global –path $ou
NEW-ADGroup -Name "Human Resources - Write” –groupscope Global –path $ou
#
NEW-ADGroup -Name "Legal - Read” –groupscope Global –path $ou
NEW-ADGroup -Name "Legal - Write” –groupscope Global –path $ou
#
NEW-ADGroup -Name "Medical Records - Read” –groupscope Global –path $ou
NEW-ADGroup -Name "Medical Records - Write” –groupscope Global –path $ou
#
NEW-ADGroup -Name "QAPI - Read” –groupscope Global –path $ou
NEW-ADGroup -Name "QAPI - Write” –groupscope Global –path $ou
#
NEW-ADGroup -Name "Renovations - Read” –groupscope Global –path $ou
NEW-ADGroup -Name "Renovations - Write” –groupscope Global –path $ou
#
NEW-ADGroup -Name "Social Services - Read” –groupscope Global –path $ou
NEW-ADGroup -Name "Social Services - Write” –groupscope Global –path $ou
#
NEW-ADGroup -Name "Therapy - Read” –groupscope Global –path $ou
NEW-ADGroup -Name "Therapy - Write” –groupscope Global –path $ou