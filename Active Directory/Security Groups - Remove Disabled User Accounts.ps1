#region Modules
Import-Module ActiveDirectory
#endregion

#region Varibles
$SecurityGroup = 'GROUP_NAME'
$Members = (Get-ADGroup $SecurityGroup -Properties members).members
#endregion

#region Process Group
foreach($member in $members){
    write-verbose "Checking '$member'..." -Verbose
    $UserStatus = Get-ADUser $member
    if(-not($UserStatus.enabled)){
        Remove-ADGroupMember $SecurityGroup -Members $member -Confirm:$false -Verbose
    }
}
#endregion