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
    # Item Check
    if (-not (Get-ItemProperty -Path $Path -Name $Name -ErrorAction SilentlyContinue)) {
        $null = New-ItemProperty -Path $Path -Name $Name -Value $Value -PropertyType $Type -Force
    } else {
        $null = Set-ItemProperty -Path $Path -Name $Name -Value $Value -Force
    }
}

## Close OneDrive (if running in background)
taskkill /f /im OneDrive.exe
taskkill /f /im FileCoAuth.exe

## Official Removal
# x86
Start-Process -FilePath "$Env:WinDir\System32\OneDriveSetup.exe" -WorkingDirectory "$Env:WinDir\System32\" -ArgumentList "/uninstall" -ErrorAction SilentlyContinue
# x64
Start-Process -FilePath "$Env:WinDir\SysWOW64\OneDriveSetup.exe" -WorkingDirectory "$Env:WinDir\SysWOW64\" -ArgumentList "/uninstall" -ErrorAction SilentlyContinue

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
Get-ScheduledTask "*OneDrive*" | Unregister-ScheduledTask -Confirm:$false -ErrorAction SilentlyContinue

## Services
$ODUPdaterService = Get-WmiObject -Class Win32_Service -Filter "Name='OneDrive Updater Service'"
$ODUPdaterService.delete() | Out-Null

## Registry
# Remove Previous Accounts/Sync Options
Set-Registry -Path "HKCU:\Software\Microsoft\OneDrive" -Remove 'Path'
# Remove previously set OneDrive settings
Set-Registry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Remove 'Path'
# Remove Right Click Menu Context Options
Set-Registry -Path "HKLM:\SYSTEM\CurrentControlSet\Services\FileSyncHelper" -Remove 'Path'
# Remove from 'Default' user account
reg load "hku\Default" "C:\Users\Default\NTUSER.DAT"
Set-Registry -Path "HKU:\Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "OneDriveSetup" -Remove 'Value'
reg unload "hku\Default"

## DISABLE File Sync / OneDrive from being used.
if (-not (Test-Path "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive")) {
    Set-Registry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive"
}
# DisableFileSync
Set-Registry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSync" -Value 1 -Type DWord
# DisableFileSyncNGSC
Set-Registry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSyncNGSC" -Value 1 -Type DWord
