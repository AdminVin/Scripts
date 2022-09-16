#region Install Sysinternals
winget install --accept-package-agreements sysinternals
# Accept EULA
handle /accepteula
#endregion

#region Function
function Find-LockedFileProcess {
    param(
        [Parameter(Mandatory)]
        [string]$FileName,

        [Parameter()]
        [string]$HandleFilePath = 'C:\Windows\System32\handle.exe'
    )

    $splitter = '------------------------------------------------------------------------------'
    $handleProcess = ((& $HandleFilePath) -join "`n") -split $splitter | Where-Object {$_ -match [regex]::Escape($FileName) }
    (($handleProcess -split "`n")[2] -split ' ')[0]
}
#endregion


