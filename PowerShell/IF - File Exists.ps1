$FileName = "C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE"
if([System.IO.File]::Exists($FileName))
{
    Write-Host "Outlook is installed!"
}
else
{
    Write-Host "Outlook is NOT installed!"
}