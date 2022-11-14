#region Settings
# Function
function Write-ProgressHelper {
	param (
	    [int]$StepNumber,
	    [string]$Message
	)

	Write-Progress -Activity 'Title' -Status $Message -PercentComplete (($StepNumber / $steps) * 100)
}
# Varibles
$script:steps = ([System.Management.Automation.PsParser]::Tokenize((Get-Content "$PSScriptRoot\$($MyInvocation.MyCommand.Name)"), [ref]$null) | Where-Object { $_.Type -eq 'Command' -and $_.Content -eq 'Write-ProgressHelper' }).Count
$stepCounter = 0
#endregion

## 0%
Write-ProgressHelper -Message 'Script Name/Action - 0%' -StepNumber ($stepCounter++)
Start-Sleep -Seconds 5

## 20%
Write-ProgressHelper -Message 'Script Name/Action - 20%' -StepNumber ($stepCounter++)
Start-Sleep -Seconds 5


## 40%
Write-ProgressHelper -Message 'Script Name/Action - 40%' -StepNumber ($stepCounter++)
Start-Sleep -Seconds 5

## 60%
Write-ProgressHelper -Message 'Script Name/Action - 60%' -StepNumber ($stepCounter++)
Start-Sleep -Seconds 5

## 80%
Write-ProgressHelper -Message 'Script Name/Action - 80%' -StepNumber ($stepCounter++)
Start-Sleep -Seconds 5

## 100%
Write-ProgressHelper -Message 'Script Name/Action - 100%' -StepNumber ($stepCounter++)
Start-Sleep -Seconds 5