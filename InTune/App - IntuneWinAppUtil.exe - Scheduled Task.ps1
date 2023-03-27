<#########################################################################################################>
<# App - IntuneWinAppUtil.exe downloaded from Github (Official)
https://github.com/Microsoft/Microsoft-Win32-Content-Prep-Tool

For this example we will deploying a scheduled task that removes the Internet Explorer addon that forces users to use Edge, and triggered on user logon.
#>


<#########################################################################################################>
<# File Setup
1. Create new directory on the C: Drive and name it "IntuneTemp", and place 'App - IntuneWinAppUtil.exe' at the root level. 

2. Create a sub directory for your task, and name it "Internet Explorer - IEtoEdge Addon Removal".

3. Export the desired task from Task Scheduler.
    - You can export this task from your computer, after running [Scripts > Internet Explorer > Addon - IE to Edge - Removal.ps1]

4. Create a new file called "Register-ScheduledTask.ps1"
    - Edit the file to include the following:

# Create directory for install detection (InTune)
New-Item -Path "C:\ProgramData\AdminVin\Internet Explorer\" -ItemType Directory -Force 
# Create file for install detection (InTune)
New-Item -Path "C:\ProgramData\AdminVin\Internet Explorer\" -Name "IEtoEDGERemoval v1.txt" -Force 
Unregister-ScheduledTask -Taskname "Internet Explorer - IEtoEDGE Removal" -Confirm:$false # Remove ol
Register-ScheduledTask -xml (Get-Content '.\InternetExplorer-IEtoEDGERemoval.xml' | Out-String) -TaskName "Internet Explorer - IEtoEDGE Removal" -Force

5. Create another new file called "Unregister-ScheduledTask.ps1"
    - Edit the file to include the following:

Unregister-ScheduledTask -Taskname "Internet Explorer - IEtoEDGE Removal" -Confirm:$false

6. Create a second sub directory and name the folder "output"

Directory structure should resemble the following.

C:/IntuneTemp/Internet Explorer - IEtoEdge Addon Removal/Register-ScheduledTask.ps1
C:/IntuneTemp/Internet Explorer - IEtoEdge Addon Removal/Unregister-ScheduledTask.ps1
C:/IntuneTemp/Internet Explorer - IEtoEdge Addon Removal/InternetExplorer-IEtoEDGERemoval.xml
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
    Next
2. Commands
    Install Command:
    powershell.exe -executionpolicy unrestricted .\Register-ScheduledTask.ps1
    Uninstall Command:
    powershell.exe -executionpolicy unrestricted .\Unegister-ScheduledTask.ps1
    Install Behavior:
    Select "System"
3. Requirements:
    Architecture: 32/64
    Version: Windows 10 1607 to target all Windows 10 PCs
4. Detection Rules:
    Rule Format > Manually configure detection rules > Add
    Rule Type
        File > Path: "C:\ProgramData\AdminVin\Internet Explorer\" (without quotes)
        File or Folder: "IEtoEDGERemoval v1.txt" (without quotes)
        Detection method: File or folder exists
        Ok

    Scope to the devices in your enviroment and deploy.
#>