$CloseTriggerFile = "\\FS\Software\Application\Close.txt"

if((Get-Content -Path $CloseTriggerFile) -eq '1')
{
    Write-Output = "Value set to 1, Force Closing all OMS Files "
    Enter-PSSession FS
    #Get-SmbOpenFile | Where-Object -Property ShareRelativePath -Match "\.mdb" | Close-SmbOpenFile -Force
    #Get-SmbOpenFile | Where-Object -Property ShareRelativePath -Match "\.ldb" | Close-SmbOpenFile -Force
	Get-SmbOpenFile | where {$_.Path –like "*TestBackendXYZ.mdb"} | Close-SmbOpenFile -Force
	Get-SmbOpenFile | where {$_.Path –like "*TestBackendXYZ.ldb"} | Close-SmbOpenFile -Force
    Exit-PSSession
    Enter-PSSession APPSERVER
    #Get-SmbOpenFile | Where-Object -Property ShareRelativePath -Match "\.mdb" | Close-SmbOpenFile -Force
    #Get-SmbOpenFile | Where-Object -Property ShareRelativePath -Match "\.ldb" | Close-SmbOpenFile -Force
	Get-SmbOpenFile | where {$_.Path –like "*.mdb"} | Close-SmbOpenFile -Force
	Get-SmbOpenFile | where {$_.Path –like "*.ldb"} | Close-SmbOpenFile -Force
    Exit-PSSession
    Set-Content '\\FS\Software\Application\Close.txt' -Value 0
    }
    Else {
    Write-Output = "Value set to 0, skipping."
    }