#region Elevating Powershell Script with Administrative Rights
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
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


#region Commit Changes
# Load PSDrive/Registry Key
New-PSDrive -PSProvider "Registry" -Root "HKEY_CLASSES_ROOT" -Name "HKCR"
$RegistryPathRoot = "HKCR"
$RegistryPathSub = "AppID\{86F80216-5DD6-4F43-953B-35EF40A35AEE}"
$RegistryPathFull = "HKCR:\AppID\{86F80216-5DD6-4F43-953B-35EF40A35AEE}"

# Local Administrators - Take Ownership
Take-Permissions $RegistryPathRoot $RegistryPathSub "S-1-5-32-544" $recurse

# Local Administrators Group - Permission Update (Full Access)
$ACL = Get-Acl $RegistryPathFull
$Identity = [System.Security.Principal.NTAccount]("$env:COMPUTERNAME\Administrators")
$AccessRights = [System.Security.AccessControl.RegistryRights]::FullControl
$InheritanceFlags = [System.Security.AccessControl.InheritanceFlags]::None
$PropagationFlags = [System.Security.AccessControl.PropagationFlags]::InheritOnly
$AccessBasedEnumeration = [System.Security.AccessControl.AccessControlType]::Allow
$Rule = New-Object System.Security.AccessControl.RegistryAccessRule ($Identity, $AccessRights, $InheritanceFlags, $PropagationFlags, $AccessBasedEnumeration)
# Overwrite all existing permissions
$ACL.SetAccessRule($Rule)
# Commit changes to registry key
$ACL | Set-Acl -Path $RegistryPathFull

# Local Administrator - Permission Update (Full Access)
$ACL = Get-Acl $RegistryPathFull
$Identity = [System.Security.Principal.NTAccount]("$env:COMPUTERNAME\Administrator")
$AccessRights = [System.Security.AccessControl.RegistryRights]::FullControl
$InheritanceFlags = [System.Security.AccessControl.InheritanceFlags]::None
$PropagationFlags = [System.Security.AccessControl.PropagationFlags]::None
$AccessBasedEnumeration = [System.Security.AccessControl.AccessControlType]::Allow
$Rule = New-Object System.Security.AccessControl.RegistryAccessRule ($Identity, $AccessRights, $InheritanceFlags, $PropagationFlags, $AccessBasedEnumeration)
# Overwrite all existing permissions
$ACL.SetAccessRule($Rule)
# Commit changes to registry key
$ACL | Set-Acl -Path $RegistryPathFull

# Local Users - Permission Update (None)
$ACL = Get-Acl $RegistryPathFull
$Identity = [System.Security.Principal.NTAccount]("$env:COMPUTERNAME\Users")
$AccessRights = [System.Security.AccessControl.RegistryRights]::Deny
$InheritanceFlags = [System.Security.AccessControl.InheritanceFlags]::None
$PropagationFlags = [System.Security.AccessControl.PropagationFlags]::None
$AccessBasedEnumeration = [System.Security.AccessControl.AccessControlType]::Allow
$Rule = New-Object System.Security.AccessControl.RegistryAccessRule ($Identity, $AccessRights, $InheritanceFlags, $PropagationFlags, $AccessBasedEnumeration)
# Add to existing permissions
$ACL.AddAccessRule($Rule)
# Commit changes to registry key
$ACL | Set-Acl -Path $RegistryPathFull

Domain Users - Permission Update (None)
$ACL = Get-Acl $RegistryPathFull
$Identity = [System.Security.Principal.NTAccount]("EBNET\DomainUsers")
$AccessRights = [System.Security.AccessControl.RegistryRights]::Deny
$InheritanceFlags = [System.Security.AccessControl.InheritanceFlags]::None
$PropagationFlags = [System.Security.AccessControl.PropagationFlags]::None
$AccessBasedEnumeration = [System.Security.AccessControl.AccessControlType]::Allow
$Rule = New-Object System.Security.AccessControl.RegistryAccessRule ($Identity, $AccessRights, $InheritanceFlags, $PropagationFlags, $AccessBasedEnumeration)
# Add to existing permissions
$ACL.AddAccessRule($Rule)
$ACL | Set-Acl -Path $RegistryPathFull

# Remove PSDrive/Registry Key
Remove-PSDrive -Name HKCR
#endregion