# Information 
# Example 1: Ok
[System.Windows.MessageBox]::Show("Please reboot your computer.")

## Yes or No
# Example 1: Concept
$result = [System.Windows.Forms.MessageBox]::Show("Do you want to proceed?`nNext Line`n`nTwo Lines Next", "Confirm", [System.Windows.Forms.MessageBoxButtons]::YesNo)

if ($result -eq [System.Windows.Forms.DialogResult]::Yes) {
    Write-Host "User clicked Yes."
} else {
    Write-Host "User clicked No."
}

# Example 2: Reboot
$result = [System.Windows.Forms.MessageBox]::Show("$AppName is ready to install.  Restart your computer now to complete installation?", "Confirm", [System.Windows.Forms.MessageBoxButtons]::YesNo)
if ($result -eq [System.Windows.Forms.DialogResult]::Yes) {
    Restart-Computer
} else {
    Write-Host "Shutdown postponed." -ForegroundColor Yellow
}