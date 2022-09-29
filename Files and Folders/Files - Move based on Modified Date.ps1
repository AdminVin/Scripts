#region Varibles
$Date = Get-Date
$CleanDate = Get-Date -UFormat "%m/%d/%Y"
$FolderPath = "C:\Folder"
$DestinationPath = $FolderPath+"\archive\"
Write-Host "Cleaning up old results files in $FolderPath" -ForegroundColor Yellow
#endregion

#region Create Archive Folder
$ArchiveCheck = $DestinationPath
if (Test-Path -Path $ArchiveCheck) {
    Write-Host "Archive folder exists, and does not need to be created." -ForegroundColor Green
} else {
    New-Item -Path "$FolderPath\archive\" -ItemType Directory
    Write-Host "Archive folder does NOT exist, and will be created." -ForegroundColor Red
}
#endregion

#region Process Clean up
Foreach($File in (Get-ChildItem $FolderPath)) { If($File.LastWriteTime -lt $Date.AddDays(-1)) { Move-Item -Path $File.fullname -Destination $DestinationPath -Force } }
Write-Host "All files older than $CleanDate were moved to $DestinationPath" -ForegroundColor DarkGreen
#endregion