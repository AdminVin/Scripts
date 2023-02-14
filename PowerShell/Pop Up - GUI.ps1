# Information (Ok)
[System.Windows.MessageBox]::Show("Please reboot your computer.")

# Yes or No
$result = [System.Windows.Forms.MessageBox]::Show("Do you want to proceed?", "Confirm", [System.Windows.Forms.MessageBoxButtons]::YesNo)

if ($result -eq [System.Windows.Forms.DialogResult]::Yes) {
    Write-Host "User clicked Yes."
} else {
    Write-Host "User clicked No."
}