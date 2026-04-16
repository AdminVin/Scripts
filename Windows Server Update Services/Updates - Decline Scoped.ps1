# Powershell Version
if ($PSVersionTable.PSEdition -ne 'Desktop' -or $PSVersionTable.PSVersion.Major -ne 5) {
    Write-Error "This script must be run in Windows PowerShell 5.1. Stopping script."
    return
}

# Module
if (-not (Get-Module -ListAvailable -Name UpdateServices)) {

    Write-Output "UpdateServices module not found. Installing WSUS management tools..."

    Install-WindowsFeature UpdateServices-API, UpdateServices-UI -ErrorAction Stop

    # Re-check after install
    if (-not (Get-Module -ListAvailable -Name UpdateServices)) {
        throw "UpdateServices module still not available after installation."
    }
}
Import-Module UpdateServices -ErrorAction Stop

# WSUS Cleanup
[void][reflection.assembly]::LoadWithPartialName("Microsoft.UpdateServices.Administration")
$WsusServer = Get-WsusServer -Name "LOCALHOST" -PortNumber 8530
$Updates = $WsusServer.GetUpdates()

# Updates - Scoped
	# ARM64
    $ARM = $Updates | Where-Object {
        $_.Title -match '\bARM64\b'
    }

    foreach ($Update in $ARM) {
        if (-not $Update.IsDeclined) {
            $Update.Decline()
            Write-Output "Declined: $($Update.Title)"
        }
    }

	# Edge
	$EdgeUpdates = $Updates | Where-Object {
		$_.Title -like "Microsoft Edge-Dev*" -or
		$_.Title -like "Microsoft Edge-Beta*"
	}

    foreach ($Update in $EdgeUpdates) {
        if (-not $Update.IsDeclined) {
            $Update.Decline()
            Write-Output "Declined: $($Update.Title)"
        }
    }

# WSUS "Cleanup Wizard"
$CleanupManager = $WsusServer.GetCleanupManager()

$CleanupScope = New-Object Microsoft.UpdateServices.Administration.CleanupScope
$CleanupScope.DeclineSupersededUpdates     = $true
$CleanupScope.DeclineExpiredUpdates       = $true
$CleanupScope.CleanupObsoleteUpdates      = $true
$CleanupScope.CleanupUnneededContentFiles = $true
$CleanupScope.CompressUpdates             = $true

$CleanupResult = $CleanupManager.PerformCleanup($CleanupScope)

$CleanupResult



