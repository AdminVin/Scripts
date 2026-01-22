# =========================================
# This will disable the revealing of wireless SSID Passwords for all non-administrators.
#   - Administrator accounts will be able to reveal/show
#   - Control Panel > Networking and Sharing Center > Change Adapter Settings > WiFi Adapter Properties > Wireless Properties > Security > Checkbox "Show characters"
#   -  Windows 10/11 Metro Settings App > Networking & internet > WiFi > SSID properties > "Show" button
# =========================================

#region Pre-Check
$FlagFile = "C:\ProgramData\AV\Wireless\PasswordRevealDisabled.txt"

if (Test-Path $FlagFile) {
	Write-Host "Wireless Reveal already applied to this computer!" -ForegroundColor Green
    return
}
#endregion

#region Configuration
# Temporary script path
$TempScript = "$env:ProgramData\OneTimeSysScript.ps1"

# Your original script content goes here, unchanged
$ScriptContent = @'
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
        if (-not $regKey) { return }
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
New-PSDrive -PSProvider "Registry" -Root "HKEY_CLASSES_ROOT" -Name "HKCR" -ErrorAction SilentlyContinue | Out-Null
$RegistryPathRoot = "HKCR"
$RegistryPathSub = "AppID\{86F80216-5DD6-4F43-953B-35EF40A35AEE}"
$RegistryPathFull = $RegistryPathRoot + ":\\" + $RegistryPathSub

Take-Permissions $RegistryPathRoot $RegistryPathSub "S-1-5-32-544" $recurse

Remove-Item -LiteralPath $RegistryPathFull -Force
New-Item -Path $RegistryPathFull

$acl = Get-Acl $RegistryPathFull
$person = [System.Security.Principal.NTAccount]"BuiltIn\Users"
$access = [System.Security.AccessControl.RegistryRights]"ReadKey, EnumerateSubKeys, QueryValues, ReadPermissions"
$inheritance = [System.Security.AccessControl.InheritanceFlags]"ContainerInherit,ObjectInherit"
$propagation = [System.Security.AccessControl.PropagationFlags]"None"
$type = [System.Security.AccessControl.AccessControlType]"Deny"
$rule = New-Object System.Security.AccessControl.RegistryAccessRule($person,$access,$inheritance,$propagation,$type)
$acl.AddAccessRule($rule)
$acl | Set-Acl

Remove-PSDrive -Name HKCR

# Create completion flag
New-Item -ItemType File -Path "C:\ProgramData\AV\Wireless\PasswordRevealDisabled.txt" -Force | Out-Null

# Self-cleanup
Remove-Item $MyInvocation.MyCommand.Path -Force
'@
#endregion

#region Write Temp Script
Set-Content -Path $TempScript -Value $ScriptContent -Encoding UTF8 -Force
#endregion

#region Setup RunOnce to Execute as SYSTEM at next boot
$RegName = "OneTimeSysScript"
$Command = "powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -File `"$TempScript`""
Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce" -Name $RegName -Value $Command
#endregion
