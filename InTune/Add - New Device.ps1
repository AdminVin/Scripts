## Step 1 - Reimage

# Step 2 - Connect to InTune
# After reimage on language selection hold Shift + press F10
PowerShell.exe -ExecutionPolicy Bypass
Install-Script -name Get-WindowsAutopilotInfo -Force
Get-WindowsAutoPilotInfo -Online
# Login to the Microsoft window prompt (if you do not see it alt+tab to bring it to the front)

<# Output:
Installing module WindowsAutopilotIntune
Connected to Intune tenant xxxxxxxxxxxx-xxx-xxx-xxxxxxxxx
Gathered details for device with serial number: xxxxxx
Waiting for 1 of 1 to be imported
#>

## Step 3 - Complete Sync and Confirm
# Wait 5 minutes, and log into Intune -> Devices -> Windows -> Windows Enrollment -> Devices -> Search for Device Serial Number > Click SYNC button at top of screen.