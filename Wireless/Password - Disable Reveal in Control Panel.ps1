#region Elevating Powershell Script with Administrative Rights
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
#endregion

#region Load HKEY_CLASSES_ROOT
New-PSDrive -PSProvider Registry -Root HKEY_CLASSES_ROOT -Name HKCR
#endregion 



#region Functions
function Take-Permissions {
    # Developed for PowerShell v4.0
    # Required Admin privileges
    # Links:
    #   http://shrekpoint.blogspot.ru/2012/08/taking-ownership-of-dcom-registry.html
    #   http://www.remkoweijnen.nl/blog/2012/01/16/take-ownership-of-a-registry-key-in-powershell/
    #   https://powertoe.wordpress.com/2010/08/28/controlling-registry-acl-permissions-with-powershell/

    param($rootKey, $key, [System.Security.Principal.SecurityIdentifier]$sid = 'S-1-5-32-545', $recurse = $true)

    switch -regex ($rootKey) {
        'HKCU|HKEY_CURRENT_USER'    { $rootKey = 'CurrentUser' }
        'HKLM|HKEY_LOCAL_MACHINE'   { $rootKey = 'LocalMachine' }
        'HKCR|HKEY_CLASSES_ROOT'    { $rootKey = 'ClassesRoot' }
        'HKCC|HKEY_CURRENT_CONFIG'  { $rootKey = 'CurrentConfig' }
        'HKU|HKEY_USERS'            { $rootKey = 'Users' }
    }

    ### Step 1 - escalate current process's privilege
    # get SeTakeOwnership, SeBackup and SeRestore privileges before executes next lines, script needs Admin privilege
    $import = '[DllImport("ntdll.dll")] public static extern int RtlAdjustPrivilege(ulong a, bool b, bool c, ref bool d);'
    $ntdll = Add-Type -Member $import -Name NtDll -PassThru
    $privileges = @{ SeTakeOwnership = 9; SeBackup =  17; SeRestore = 18 }
    foreach ($i in $privileges.Values) {
        $null = $ntdll::RtlAdjustPrivilege($i, 1, 0, [ref]0)
    }

    function Take-KeyPermissions {
        param($rootKey, $key, $sid, $recurse, $recurseLevel = 0)

        ### Step 2 - get ownerships of key - it works only for current key
        $regKey = [Microsoft.Win32.Registry]::$rootKey.OpenSubKey($key, 'ReadWriteSubTree', 'TakeOwnership')
        $acl = New-Object System.Security.AccessControl.RegistrySecurity
        $acl.SetOwner($sid)
        $regKey.SetAccessControl($acl)

        ### Step 3 - enable inheritance of permissions (not ownership) for current key from parent
        $acl.SetAccessRuleProtection($false, $false)
        $regKey.SetAccessControl($acl)

        ### Step 4 - only for top-level key, change permissions for current key and propagate it for subkeys
        # to enable propagations for subkeys, it needs to execute Steps 2-3 for each subkey (Step 5)
        if ($recurseLevel -eq 0) {
            $regKey = $regKey.OpenSubKey('', 'ReadWriteSubTree', 'ChangePermissions')
            $rule = New-Object System.Security.AccessControl.RegistryAccessRule($sid, 'FullControl', 'ContainerInherit', 'None', 'Allow')
            $acl.ResetAccessRule($rule)
            $regKey.SetAccessControl($acl)
        }

        ### Step 5 - recursively repeat steps 2-5 for subkeys
        if ($recurse) {
            foreach($subKey in $regKey.OpenSubKey('').GetSubKeyNames()) {
                Take-KeyPermissions $rootKey ($key+'\'+$subKey) $sid $recurse ($recurseLevel+1)
            }
        }
    }

    Take-KeyPermissions $rootKey $key $sid $recurse
}
#endregion



#region Take Ownership (to read the registry key)
Take-Permissions $RegistryPathRoot $RegistryPathSub "S-1-1-0"
#endregion



#region Permissions -  Domain Admins - Full Access

# Registry Key Path
$RegistryPathFull = "HKCR:\AppID\{86F80216-5DD6-4F43-953B-35EF40A35AEE}"
$RegistryPathRoot = "HKCR"
$RegistryPathSub = "AppID\{86F80216-5DD6-4F43-953B-35EF40A35AEE}"

# Registry Key
$ACL = Get-Acl $RegistryPathFull

# Domain Account or Group
$Identity = [System.Security.Principal.NTAccount]("DOMAIN\Domain Admins")

# New Permissions
$AccessRights = [System.Security.AccessControl.RegistryRights]::FullControl

# Inheritance
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