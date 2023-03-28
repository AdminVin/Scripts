<#########################################################################################################>
<# App - IntuneWinAppUtil.exe downloaded from Github (Official)
https://github.com/Microsoft/Microsoft-Win32-Content-Prep-Tool

For this example we will deploying a scheduled task that removes the Internet Explorer addon that forces users to use Edge, and triggered on user logon.
#>


<#########################################################################################################>
<# File Setup
1. Create new directory on the C: Drive and name it "IntuneTemp", and place 'App - IntuneWinAppUtil.exe' at the root level. 

2. Create a sub directory for your task, and name it "Internet Explorer - IEtoEdge Addon Removal".

3. Create a new file called "Register-ScheduledTask.ps1"
    - Edit the file to include the following:

# File Detection Setup
$Dir = "C:\ProgramData\CompanyName\Internet Explorer\"
$File = "IEtoEDGEAddonRemoval v1.txt"
New-Item -Path $Dir -ItemType Directory -Force | Out-Null
New-Item -Path $Dir -Name $File -Force | Out-Null
Set-Content $Dir$File -Value "Synced and installed at $(Get-Date -Format 'M-d-yyyy_HHmm')"
# Remove OLD Scheduled Task (Clean Install)
Unregister-ScheduledTask -Taskname "Internet Explorer - IEtoEDGE Addon Removal" -Confirm:$false
# Create NEW Scheduled Task
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "Get-ChildItem -Path 'C:\Program Files (x86)\Microsoft\Edge\Application' -Recurse -Filter 'BHO' | Remove-Item -Force -Recurse"
$trigger = New-ScheduledTaskTrigger -AtLogOn
$STPrin = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "Internet Explorer - IEtoEDGE Addon Removal" -Description "Removes the Internet Explorer Addon IEtoEDGE.  This will permit the use of Internet Explorer." -Principal $STPrin

4. Create another new file called "Unregister-ScheduledTask.ps1"
    - Edit the file to include the following:

Unregister-ScheduledTask -Taskname "Internet Explorer - IEtoEDGE Addon Removal" -Confirm:$false

5. Create a second sub directory and name the folder "Output"

Directory structure should resemble the following.

C:/IntuneTemp/Internet Explorer - IEtoEdge Addon Removal/Register-ScheduledTask.ps1
C:/IntuneTemp/Internet Explorer - IEtoEdge Addon Removal/Unregister-ScheduledTask.ps1
C:/IntuneTemp/Output
C:/IntuneTemp/App - IntuneWinAppUtil.exe

#>


<#########################################################################################################>
<# IntuneWinAppUtil.exe Process
1. Run CMD/Powershell/Terminal and navigate to C:/IntuneTemp

2. Run: & '.\App - IntuneWinAppUtil.exe'
    Specify source folder --- "C:\InTuneTemp\Internet Explorer - IEtoEDGE Removal" (with quotes)
    Specify setup file --- "C:\InTuneTemp\Internet Explorer - IEtoEDGE Removal\Register-ScheduledTask.ps1" (with quotes)
    Specify output folder --- "C:\InTuneTemp\Output" (with quotes)
    Specify catalog folder --- No

Register-ScheduledTask.intunewin is created in the output folder (C:/IntuneTemp/Output)

#>


<#########################################################################################################>
<# InTune Configuration
1. Navigate to https://endpoint.microsoft.com/ > Apps > All Apps > Add > Dropdown & select 'Windows app (Win32)
    Select the file created Register-ScheduledTask.intunewin
    Enter in Name, Description, and Publisher
    
2. Commands
    Install Command:
    Powershell.exe -ExecutionPolicy Unrestricted .\Register-ScheduledTask.ps1

    Uninstall Command:
    Powershell.exe -ExecutionPolicy Unrestricted .\Unegister-ScheduledTask.ps1
    
    Install Behavior:
    Select "System"

3. Requirements:
    Architecture: 32/64
    Version: Windows 10 1607 to target all Windows 10/11 Computers

4. Detection Rules:
    Rule Format > Manually configure detection rules > Add
    Rule Type
        File > Path: "C:\ProgramData\AdminVin\Internet Explorer\" (without quotes)
        File or Folder: "IEtoEDGERemoval v1.txt" (without quotes)
        Detection method: File or folder exists
        Ok

    Set Scope/Group to the devices in your enviroment and deploy.
#>