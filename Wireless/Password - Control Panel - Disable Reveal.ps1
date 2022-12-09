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

#region Commit Changes
# Load PSDrive/Registry Key
New-PSDrive -PSProvider "Registry" -Root "HKEY_CLASSES_ROOT" -Name "HKCR" -ErrorAction SilentlyContinue | Out-Null
$RegistryPathRoot = "HKCR"
$RegistryPathSub = "AppID\{86F80216-5DD6-4F43-953B-35EF40A35AEE}"
$RegistryPathFull = $RegistryPathRoot + ":\" + $RegistryPathSub
# Local Administrators - Take Ownership
Take-Permissions $RegistryPathRoot $RegistryPathSub "S-1-5-32-544" $recurse
# Remove Existing Key
Remove-Item -LiteralPath $RegistryPathFull -Force
# Create New Key (Reset Permissions)
New-Item -Path $RegistryPathFull
# Permissions Revoke All
$acl = Get-Acl $RegistryPathFull
$person = [System.Security.Principal.NTAccount]"BuiltIn\Users"          
$access = [System.Security.AccessControl.RegistryRights]"Fullcontrol"
$inheritance = [System.Security.AccessControl.InheritanceFlags]"ContainerInherit,ObjectInherit"
$propagation = [System.Security.AccessControl.PropagationFlags]"None"
$type = [System.Security.AccessControl.AccessControlType]"Deny"
$rule = New-Object System.Security.AccessControl.RegistryAccessRule($person,$access,$inheritance,$propagation,$type)
$acl.AddAccessRule($rule)
$acl | Set-Acl
# Remove PSDrive/Registry Key
Remove-PSDrive -Name HKCR
#endregion