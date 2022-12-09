#region Elevating Powershell Script with Administrative Rights
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
#endregion

#region Functions
function Take-Permissions {
    param($rootKey, $key, [System.Security.Principal.SecurityIdentifier]$sid = 'S-1-5-32-545', $recurse = $true)

    switch -regex ($rootKey) {
        'HKCU|HKEY_CURRENT_USER'    { $rootKey = 'CurrentUser' }
        'HKLM|HKEY_LOCAL_MACHINE'   { $rootKey = 'LocalMachine' }
        'HKCR|HKEY_CLASSES_ROOT'    { $rootKey = 'ClassesRoot' }
        'HKCC|HKEY_CURRENT_CONFIG'  { $rootKey = 'CurrentConfig' }
        'HKU|HKEY_USERS'            { $rootKey = 'Users' }
    }
    $import = '[DllImport("ntdll.dll")] public static extern int RtlAdjustPrivilege(ulong a, bool b, bool c, ref bool d);'
    $ntdll = Add-Type -Member $import -Name NtDll -PassThru
    $privileges = @{ SeTakeOwnership = 9; SeBackup =  17; SeRestore = 18 }
    foreach ($i in $privileges.Values) {
        $null = $ntdll::RtlAdjustPrivilege($i, 1, 0, [ref]0)
    }

    function Take-KeyPermissions {
        param($rootKey, $key, $sid, $recurse, $recurseLevel = 0)

        $regKey = [Microsoft.Win32.Registry]::$rootKey.OpenSubKey($key, 'ReadWriteSubTree', 'TakeOwnership')
        $acl = New-Object System.Security.AccessControl.RegistrySecurity
        $acl.SetOwner($sid)
        $regKey.SetAccessControl($acl)

        $acl.SetAccessRuleProtection($false, $false)
        $regKey.SetAccessControl($acl)

        if ($recurseLevel -eq 0) {
            $regKey = $regKey.OpenSubKey('', 'ReadWriteSubTree', 'ChangePermissions')
            $rule = New-Object System.Security.AccessControl.RegistryAccessRule($sid, 'FullControl', 'ContainerInherit', 'None', 'Allow')
            $acl.ResetAccessRule($rule)
            $regKey.SetAccessControl($acl)
        }

        if ($recurse) {
            foreach($subKey in $regKey.OpenSubKey('').GetSubKeyNames()) {
                Take-KeyPermissions $rootKey ($key+'\'+$subKey) $sid $recurse ($recurseLevel+1)
            }
        }
    }
    Take-KeyPermissions $rootKey $key $sid $recurse
}
#endregion

#region Load Registry Key
New-PSDrive -PSProvider "Registry" -Root "HKEY_CLASSES_ROOT" -Name "HKCR"
$RegistryPathRoot = "HKCR"
$RegistryPathSub = "AppID\{86F80216-5DD6-4F43-953B-35EF40A35AEE}"
$RegistryPathFull = "HKCR:\AppID\{86F80216-5DD6-4F43-953B-35EF40A35AEE}"
#endregion 


#region Commit Changes
# Take Ownership
Take-Permissions $RegistryPathRoot $RegistryPathSub $recurse
#Permissions - Domain Admins - Full Access
$ACL = Get-Acl $RegistryPathFull
# Account or Group ("DOMAIN\Domain Admins", "BUILTIN\Administrators", or "PCNAME\LOCALUSERACCOUNT")
$Identity = [System.Security.Principal.NTAccount]("DOMAIN\Domain Admins")
# New Permissions (FullControl, ReadKey, WriteKey, or TakeOwnership)
$AccessRights = [System.Security.AccessControl.RegistryRights]::FullControl

<# Propagation/Inheritance Access Chart
╔═════════════╦═════════════╦═══════════════════════════════╦════════════════════════╦══════════════════╦═══════════════════════╦═════════════╦═════════════╗
║             ║ folder only ║ folder, sub-folders and files ║ folder and sub-folders ║ folder and files ║ sub-folders and files ║ sub-folders ║    files    ║
╠═════════════╬═════════════╬═══════════════════════════════╬════════════════════════╬══════════════════╬═══════════════════════╬═════════════╬═════════════╣
║ Propagation ║ none        ║ none                          ║ none                   ║ none             ║ InheritOnly           ║ InheritOnly ║ InheritOnly ║
║ Inheritance ║ none        ║ Container|Object              ║ Container              ║ Object           ║ Container|Object      ║ Container   ║ Object      ║
╚═════════════╩═════════════╩═══════════════════════════════╩════════════════════════╩══════════════════╩═══════════════════════╩═════════════╩═════════════╝
#>
# Inheritance of permissions from root folder (InheritOnly, None, NoPropagateInherit)
$InheritanceFlags = [System.Security.AccessControl.InheritanceFlags]::None
# Propgation to Child Items
$PropagationFlags = [System.Security.AccessControl.PropagationFlags]::None

# Access Based Enumeration
$AccessBasedEnumeration = [System.Security.AccessControl.AccessControlType]::Allow

# Combine previous varibles into one for the rule
$Rule = New-Object System.Security.AccessControl.RegistryAccessRule ($Identity, $AccessRights, $InheritanceFlags, $PropagationFlags, $AccessBasedEnumeration)

# Add to existing permissions
#$ACL.AddAccessRule($Rule)

# Overwrite all existing permissions
$ACL.SetAccessRule($Rule)

# Commit changes to registry key
$ACL | Set-Acl -Path $RegistryPath
#endregion



#region Permissions -  Domain Users, Everyone, Users, Creator Owner - Revoke
# Import-Module .\"Password - Disable Reveal In Control Panel-Carbon.psm1"
Install-Module -Name "Carbon" -AllowClobber -Force
Import-Module -Name Carbon
Revoke-CPermission -Identity "Everyone" -Path $RegistryPathFull
Revoke-CPermission -Identity "DOMAIN\Domain Users" -Path $RegistryPathFull
Revoke-CPermission -Identity "Users" -Path $RegistryPathFull
Revoke-CPermission -Identity "CREATOR OWNER" -Path $RegistryPathFull
#endregion



#region Unload HKEY_CLASSES_ROOT
Remove-PSDrive -Name HKCR
#endregion