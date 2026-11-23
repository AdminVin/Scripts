## Functions
function Set-Registry {
    param (
        [string]$Path,
        [string]$Name,
        [Parameter(ValueFromPipeline = $true)]
        [Object]$Value,
        [ValidateSet('String','ExpandString','Binary','DWord','MultiString','QWord')]
        [string]$Type,
        [ValidateSet('Path','Value')]
        [string]$Remove
    )
    # Removal Check
    if ($Remove -eq 'Path') {
        if (Test-Path $Path) {
            Remove-Item -Path $Path -Recurse -Force -ErrorAction SilentlyContinue
        }
        return
    }
    if ($Remove -eq 'Value') {
        if (Test-Path $Path) {
            if (Get-ItemProperty -Path $Path -Name $Name -ErrorAction SilentlyContinue) {
                Remove-ItemProperty -Path $Path -Name $Name -Force -ErrorAction SilentlyContinue
            }
        }
        return
    }
    # Path Check
    if (-not (Test-Path $Path)) {
        $null = New-Item -Path $Path -Force
    }
    # Empty Name Check
    if ([string]::IsNullOrEmpty($Name)) {
        return
    }
    # Item Check
    if (-not (Get-ItemProperty -Path $Path -Name $Name -ErrorAction SilentlyContinue)) {
        $null = New-ItemProperty -Path $Path -Name $Name -Value $Value -PropertyType $Type -Force
    } else {
        $null = Set-ItemProperty -Path $Path -Name $Name -Value $Value -Force
    }
}

## Close OneDrive (if running in background)
Get-Process -Name OneDrive,FileCoAuth -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue

## OneDrive Sync Database Cleanup
# Find every account settings folder
$settingsRoot = "$env:LOCALAPPDATA\Microsoft\OneDrive\settings"
$accountFolders = Get-ChildItem -Path $settingsRoot -Directory -ErrorAction SilentlyContinue

$dbFileNames = @(
    'SyncEngineDatabase.db',
    'SyncEngineDatabase.db-wal',
    'SyncEngineDatabase.db-shm'
)

# Remove sync databases from all account settings folders
foreach ($accountFolder in $accountFolders) {
    foreach ($dbFileName in $dbFileNames) {
        Remove-Item -LiteralPath (Join-Path $accountFolder.FullName $dbFileName) -Force -ErrorAction SilentlyContinue
    }
}

## OneDrive AppData Cleanup
# AppData / Local / Microsoft
Remove-Item -Path "$env:LOCALAPPDATA\Microsoft\OneDrive" -Recurse -Confirm:$false -Force -ErrorAction SilentlyContinue

# AppData / Local
Remove-Item -Path "$env:LOCALAPPDATA\OneDrive" -Recurse -Confirm:$false -Force -ErrorAction SilentlyContinue

# AppData / Roaming / Microsoft
Remove-Item -Path "$env:APPDATA\Microsoft\OneDrive" -Recurse -Confirm:$false -Force -ErrorAction SilentlyContinue

# AppData / Roaming
Remove-Item -Path "$env:APPDATA\OneDrive" -Recurse -Confirm:$false -Force -ErrorAction SilentlyContinue

## Official Removal
# Installed OneDrive versions
$OneDriveInstallers = @(
    "$env:ProgramFiles\Microsoft OneDrive\OneDriveSetup.exe"
    "${env:ProgramFiles(x86)}\Microsoft OneDrive\OneDriveSetup.exe"
)

# Include version-specific OneDrive installers
$OneDriveInstallers += @(
    Get-ChildItem -Path "$env:ProgramFiles\Microsoft OneDrive",
                         "${env:ProgramFiles(x86)}\Microsoft OneDrive" `
        -Filter "OneDriveSetup.exe" -Recurse -File -ErrorAction SilentlyContinue |
        Select-Object -ExpandProperty FullName
)

# Remove duplicates and empty paths
$OneDriveInstallers = @(
    $OneDriveInstallers |
        Where-Object { -not [string]::IsNullOrWhiteSpace($_) } |
        Select-Object -Unique
)

# Uninstall installed versions first
foreach ($Installer in $OneDriveInstallers) {
    if (-not [string]::IsNullOrWhiteSpace($Installer) -and (Test-Path -LiteralPath $Installer -PathType Leaf)) {
        if ((Get-AuthenticodeSignature -LiteralPath $Installer).Status -eq 'Valid') {
            Unblock-File -LiteralPath $Installer -ErrorAction SilentlyContinue
        }
        Start-Process -FilePath $Installer -ArgumentList "/uninstall /allusers" -Wait -ErrorAction SilentlyContinue
    }
}

# x86
if (Test-Path "$Env:WinDir\System32\OneDriveSetup.exe") {
    Start-Process -FilePath "$Env:WinDir\System32\OneDriveSetup.exe" -WorkingDirectory "$Env:WinDir\System32\" -ArgumentList "/uninstall" -Wait -ErrorAction SilentlyContinue
}
# x64
if (Test-Path "$Env:WinDir\SysWOW64\OneDriveSetup.exe") {
    Start-Process -FilePath "$Env:WinDir\SysWOW64\OneDriveSetup.exe" -WorkingDirectory "$Env:WinDir\SysWOW64\" -ArgumentList "/uninstall" -Wait -ErrorAction SilentlyContinue
}

## Files Cleanup
# File Explorer - Navigation Bar
if((Test-Path -LiteralPath "HKCU:\Software\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}") -ne $true) {  New-Item "HKCU:\Software\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Force -ErrorAction SilentlyContinue | Out-Null };
Set-Registry -Path 'HKCU:\Software\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}' -Name '(default)' -Value 'OneDrive' -Type String
Set-Registry -Path 'HKCU:\Software\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}' -Name 'System.IsPinnedToNameSpaceTree' -Value 0 -Type DWord
# AppData / Local
Remove-Item -Path "$env:localappdata\OneDrive" -Recurse -Confirm:$false -Force -ErrorAction SilentlyContinue
# ProgramData
Remove-Item -Path "$env:programdata\Microsoft OneDrive" -Recurse -Force -ErrorAction SilentlyContinue
# Shortcuts
Remove-Item -Path "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk" -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk" -Force -ErrorAction SilentlyContinue
# Program Files
Remove-Item -LiteralPath "C:\Program Files (x86)\Microsoft OneDrive" -Recurse -Confirm:$false -Force -ErrorAction SilentlyContinue
Remove-Item -LiteralPath "C:\Program Files\Microsoft OneDrive" -Recurse -Confirm:$false -Force -ErrorAction SilentlyContinue

## Scheduled Tasks
Get-ScheduledTask "*OneDrive*" -ErrorAction SilentlyContinue | Unregister-ScheduledTask -Confirm:$false -ErrorAction SilentlyContinue

## Services
$ODUPdaterService = Get-CimInstance -ClassName Win32_Service -Filter "Name='OneDrive Updater Service'" -ErrorAction SilentlyContinue
if ($ODUPdaterService) {
    $ODUPdaterService | Invoke-CimMethod -MethodName Delete -ErrorAction SilentlyContinue | Out-Null
}

## Registry
# Remove Previous Accounts/Sync Options
Set-Registry -Path "HKCU:\Software\Microsoft\OneDrive" -Remove 'Path'
# Remove previously set OneDrive settings
Set-Registry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Remove 'Path'
# Remove Right Click Menu Context Options
Set-Registry -Path "HKLM:\SYSTEM\CurrentControlSet\Services\FileSyncHelper" -Remove 'Path'
# Remove from launching on new user profiles
Set-Registry -Remove Value -Path 'Registry::HKEY_USERS\.DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' -Name 'OneDriveSetup'
Set-Registry -Remove Value -Path 'Registry::HKEY_USERS\.DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce' -Name 'OneDrive'

# Remove from 'Default' user account
reg load "hku\Default" "C:\Users\Default\NTUSER.DAT"
Set-Registry -Path "Registry::HKEY_USERS\Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "OneDriveSetup" -Remove 'Value'
reg unload "hku\Default"

## Remove Remaining OneDrive Installation Registry Entries
@(
    'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall'
    'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall'
    'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall'
) | ForEach-Object {
    Get-ChildItem -Path $_ -ErrorAction SilentlyContinue | ForEach-Object {
        $Entry = Get-ItemProperty -Path $_.PSPath -ErrorAction SilentlyContinue
        if ($Entry.DisplayName -like '*OneDrive*') {
            Remove-Item -LiteralPath $_.PSPath -Recurse -Force -ErrorAction SilentlyContinue
        }
    }
}

## Remove Remaining OneDrive Version Registrations
# Machine-wide OneDrive installation
Set-Registry -Path "HKLM:\SOFTWARE\Microsoft\OneDrive" -Remove 'Path'

# 32-bit OneDrive installation registration
Set-Registry -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\OneDrive" -Remove 'Path'

# OneDrive Photos installation registration
Set-Registry -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ODPhotosOneDriveSetup.exe" -Remove 'Path'

## Enable File Sync (if somehow disabled)
if (-not (Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive")) {
    Set-Registry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive"
}
# DisableFileSync
Set-Registry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSync" -Value 0 -Type DWord
# DisableFileSyncNGSC
Set-Registry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSyncNGSC" -Value 0 -Type DWord